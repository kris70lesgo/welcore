#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/toolchain.sh"
python3 "$ADMS_ROOT/scripts/test_preview.py"
cd "$ADMS_ROOT/backend/adms_server"
dart pub get
dart analyze
dart test -r expanded
cd "$ADMS_ROOT/source/flutter/adms"
flutter pub get
flutter analyze --no-pub lib/features/serverpod lib/main.dart test/serverpod test/widget_test.dart
flutter test --no-pub
flutter build web --release --no-pub --no-web-resources-cdn
