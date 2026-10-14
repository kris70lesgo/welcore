#!/usr/bin/env python3
"""Serve the web release and cache requested OSM tiles for local previews.

Only coordinate-validated requests to the fixed public tile host are proxied.
The dispatch API and every application record remain owned by Serverpod.
"""
import argparse
import functools
import http.server
import pathlib
import re
import urllib.error
import urllib.request

TILE_ROUTE = re.compile(r"^/map-tiles/(\d{1,2})/(\d{1,7})/(\d{1,7})\.png$")
CACHE = pathlib.Path(__file__).resolve().parent.parent / '.local' / 'map-tiles'


def tile_coordinates(path):
    match = TILE_ROUTE.fullmatch(path)
    if not match:
        return None
    z, x, y = map(int, match.groups())
    if not 0 <= z <= 19 or not 0 <= x < 2**z or not 0 <= y < 2**z:
        return None
    return z, x, y


class PreviewHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if not self.path.startswith('/map-tiles/'):
            return super().do_GET()
        coords = tile_coordinates(self.path)
        if coords is None:
            self.send_error(400, 'Invalid map tile coordinates')
            return
        z, x, y = coords
        cache_file = CACHE / str(z) / str(x) / f'{y}.png'
        try:
            if cache_file.exists():
                payload = cache_file.read_bytes()
            else:
                request = urllib.request.Request(
                    f'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    headers={'User-Agent': 'ADMSDispatchHackathon/1.0 (local preview)'})
                with urllib.request.urlopen(request, timeout=15) as response:
                    payload = response.read(512 * 1024)
                if not payload.startswith(b'\x89PNG\r\n\x1a\n'):
                    raise ValueError('Tile service returned a non-PNG response')
                cache_file.parent.mkdir(parents=True, exist_ok=True)
                cache_file.write_bytes(payload)
            self.send_response(200)
            self.send_header('Content-Type', 'image/png')
            self.send_header('Content-Length', str(len(payload)))
            self.send_header('Cache-Control', 'public, max-age=86400')
            self.end_headers()
            self.wfile.write(payload)
        except (OSError, ValueError, urllib.error.URLError):
            self.send_error(502, 'Map tile service unavailable')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--port', type=int, default=8181)
    parser.add_argument('--directory', default=str(pathlib.Path(__file__).resolve().parent.parent / 'source/flutter/adms/build/web'))
    options = parser.parse_args()
    handler = functools.partial(PreviewHandler, directory=options.directory)
    server = http.server.ThreadingHTTPServer(('127.0.0.1', options.port), handler)
    print(f'ADMS Dispatch preview: http://localhost:{options.port}', flush=True)
    server.serve_forever()
