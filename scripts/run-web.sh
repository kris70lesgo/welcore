#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/toolchain.sh"
cd "$ADMS_ROOT/source/flutter/adms"
flutter pub get
flutter build web --release --no-web-resources-cdn '--dart-define=MAP_TILE_URL=/map-tiles/{z}/{x}/{y}.png' "--dart-define=SERVERPOD_URL=${SERVERPOD_URL:-http://localhost:8080/}"
python3 "$ADMS_ROOT/scripts/serve-web.py" --port "${ADMS_WEB_PORT:-8181}" --directory build/web
