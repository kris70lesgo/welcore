#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/toolchain.sh"
cd "$ADMS_ROOT/backend/adms_server"
if [[ ! -f config/passwords.yaml ]]; then cp config/passwords.yaml.example config/passwords.yaml; fi
dart pub get
dart run bin/main.dart --apply-migrations
