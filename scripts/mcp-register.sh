#!/usr/bin/env bash
# Purpose: Register an MCP server in opencode.json.
# Docs: mcp-register.sh.doc.md

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

NAME=""
COMMAND=""
ENABLED=true
ENV_JSON="{}"
CONFIG=""

usage() {
    echo "Usage: $0 -n <name> -c '<command>' [-e] [-E <env_json>] [-C <config_path>]"
    echo "  -n  Server name (mcp section key)"
    echo "  -c  Command + args, space-separated"
    echo "  -e  Disable the server (default: enabled)"
    echo "  -E  JSON object of env vars (default: {})"
    echo "  -C  Path to opencode.json (default: auto-discover)"
    exit 1
}

while getopts ":n:c:eE:C:" opt; do
    case $opt in
        n) NAME="$OPTARG" ;;
        c) COMMAND="$OPTARG" ;;
        e) ENABLED=false ;;
        E) ENV_JSON="$OPTARG" ;;
        C) CONFIG="$OPTARG" ;;
        *) usage ;;
    esac
done

if [ -z "$NAME" ] || [ -z "$COMMAND" ]; then
    usage
fi

python3 - "$NAME" "$COMMAND" "$ENABLED" "$ENV_JSON" "$CONFIG" <<'PY'
import json
import sys
from pathlib import Path

name, command, enabled, env_json, config = sys.argv[1:]
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
from sin_mcp_server_builder import Registrar, build_local_entry

entry = build_local_entry(name, command.split(), json.loads(env_json))
entry.enabled = (enabled.lower() == "true")
path = Registrar(config_path=Path(config) if config else None).register(entry)
print(json.dumps({"config_path": str(path), "entry": entry.to_json()}, indent=2))
PY
