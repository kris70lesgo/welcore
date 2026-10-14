#!/usr/bin/env bash
set -euo pipefail
ADMS_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ADMS_ROOT"
mkdir -p .local
if [[ ! -f .local/judge.env ]]; then
  umask 077
  python3 - <<'PY'
import secrets
from pathlib import Path
Path('.local/judge.env').write_text(
    'ADMS_JUDGE_DB_PASSWORD=' + secrets.token_hex(24) + '\n' +
    'ADMS_JUDGE_SERVICE_SECRET=' + secrets.token_hex(32) + '\n')
PY
fi
if [[ ! -f deploy/web/main.dart.js ]]; then
  echo 'Missing web release. Run scripts/build-judge.sh or download the judge test-build archive.' >&2
  exit 1
fi
mkdir -p backend/adms_server/web/app
cp -R deploy/web/. backend/adms_server/web/app/
docker compose --env-file .local/judge.env -f compose.judge.yaml up --build -d
echo 'ADMS judge app: http://localhost:8182 (API/database remain private to Docker)'
