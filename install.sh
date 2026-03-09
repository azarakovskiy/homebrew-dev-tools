#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[install.sh] Deprecated entrypoint. Delegating to bootstrap.sh"
exec "$SCRIPT_DIR/bootstrap.sh" --apply --verify "$@"
