#!/usr/bin/env bash
# Purpose: Add a new tool to an existing MCP server.
# Docs: mcp-add-tool.sh.doc.md

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SERVER=""
TOOL_NAME=""
DESCRIPTION=""
PARAMS_JSON="[]"
BODY='result = {"ok": True}'

usage() {
    echo "Usage: $0 -s <server.py> -n <tool_name> -d <description> [-p '<params json>'] [-b '<body>']"
    echo "  -s  Path to mcp_server.py"
    echo "  -n  Tool name (snake_case)"
    echo "  -d  Tool description"
    echo "  -p  JSON list of [name, type, default] tuples (default: [])"
    echo "  -b  Python body (default: result = {\"ok\": True})"
    exit 1
}

while getopts ":s:n:d:p:b:" opt; do
    case $opt in
        s) SERVER="$OPTARG" ;;
        n) TOOL_NAME="$OPTARG" ;;
        d) DESCRIPTION="$OPTARG" ;;
        p) PARAMS_JSON="$OPTARG" ;;
        b) BODY="$OPTARG" ;;
        *) usage ;;
    esac
done

if [ -z "$SERVER" ] || [ -z "$TOOL_NAME" ] || [ -z "$DESCRIPTION" ]; then
    usage
fi

python3 - "$SERVER" "$TOOL_NAME" "$DESCRIPTION" "$PARAMS_JSON" "$BODY" <<'PY'
import json
import sys
from pathlib import Path

server, tool_name, description, params_json, body = sys.argv[1:]
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from sin_mcp_server_builder import ToolAdder, ToolSpec

params = json.loads(params_json)
spec = ToolSpec(
    name=tool_name,
    description=description,
    params=[(p[0], p[1], p[2] if len(p) > 2 else "") for p in params],
    body=body,
)
source = ToolAdder().add_to_python(Path(server), spec)
print(source)
PY
