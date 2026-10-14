import importlib.util
import pathlib
import unittest

spec = importlib.util.spec_from_file_location('adms_preview', pathlib.Path(__file__).with_name('serve-web.py'))
preview = importlib.util.module_from_spec(spec)
spec.loader.exec_module(preview)

class TileRouteTests(unittest.TestCase):
    def test_valid_coordinate(self):
        self.assertEqual(preview.tile_coordinates('/map-tiles/13/6849/3759.png'), (13, 6849, 3759))

    def test_only_fixed_numeric_routes_are_accepted(self):
        for route in ['/map-tiles/../../config/passwords.yaml', '/map-tiles/https://example.com',
                      '/map-tiles/1/0/0.png?url=https://example.com', '/map-tiles/-1/0/0.png',
                      '/map-tiles/20/0/0.png', '/map-tiles/1/2/0.png', '/map-tiles/1/0/2.png']:
            with self.subTest(route=route):
                self.assertIsNone(preview.tile_coordinates(route))

if __name__ == '__main__':
    unittest.main()
