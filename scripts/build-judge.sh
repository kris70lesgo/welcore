#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/toolchain.sh"
cd "$ADMS_ROOT/source/flutter/adms"
flutter pub get
flutter build web --release --no-web-resources-cdn --dart-define=SERVERPOD_URL=/api/ --output "$ADMS_ROOT/deploy/web"
