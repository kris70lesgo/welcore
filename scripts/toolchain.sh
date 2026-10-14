#!/usr/bin/env bash
# Source this from project scripts; prefer the user's SDK over the local SDK.
ADMS_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if ! command -v flutter >/dev/null 2>&1; then
  if [[ -x "$ADMS_ROOT/../.tooling/flutter/bin/flutter" ]]; then
    export PATH="$ADMS_ROOT/../.tooling/flutter/bin:$PATH"
  else
    echo 'Flutter is required. Install a stable Flutter SDK with Dart >= 3.12.2 and add flutter/bin to PATH.' >&2
    return 1
  fi
fi
