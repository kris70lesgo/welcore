#!/usr/bin/env python3
"""Package reviewable source, generated protocol, migrations and documentation."""
import pathlib
import zipfile

root = pathlib.Path(__file__).resolve().parent.parent
output = root.parent / 'adms-serverpod-source.zip'
excluded = {'.git', '.dart_tool', '.pub-cache', '.local', '.tooling', '.serverpod',
            'build', 'node_modules', 'coverage', 'ephemeral', 'Pods', '__pycache__', '.idea'}
count = 0
with zipfile.ZipFile(output, 'w', zipfile.ZIP_DEFLATED) as archive:
    for path in sorted(root.rglob('*')):
        if not path.is_file():
            continue
        relative = path.relative_to(root)
        if excluded.intersection(relative.parts):
            continue
        if relative.as_posix().startswith(('deploy/web/', 'backend/adms_server/web/app/')):
            continue
        if path.name in {'passwords.yaml', '.env', 'firebase_options.dart', '.flutter-plugins-dependencies'}:
            continue
        if path.name.startswith('analyze_') or path.suffix in {'.log', '.zip', '.pyc', '.iml'}:
            continue
        archive.write(path, pathlib.Path('adms-dispatch') / relative)
        count += 1
print(f'Packaged {count} source files: {output}')
