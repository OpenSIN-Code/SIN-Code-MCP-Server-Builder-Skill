#!/usr/bin/env bash
# Purpose: Scaffold a new MCP server from a spec.
# Docs: mcp-scaffold.sh.doc.md

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

NAME=""
DESCRIPTION=""
TARGET="./out"
TOOLS="ping"
TEMPLATE="python-fastmcp"
VERSION="0.1.0"

usage() {
    echo "Usage: $0 -n <name> -d <description> [-t <target>] [-T <template>] [-o <tools>] [-v <version>]"
    echo "  -n  Server name (e.g. 'My Cool Tool')"
    echo "  -d  One-line description"
    echo "  -t  Target directory (default: ./out)"
    echo "  -T  Template: python-fastmcp|node-mcp|go-mcp (default: python-fastmcp)"
    echo "  -o  Comma-separated tool names (default: ping)"
    echo "  -v  Initial semver version (default: 0.1.0)"
    exit 1
}

while getopts ":n:d:t:T:o:v:" opt; do
    case $opt in
        n) NAME="$OPTARG" ;;
        d) DESCRIPTION="$OPTARG" ;;
        t) TARGET="$OPTARG" ;;
        T) TEMPLATE="$OPTARG" ;;
        o) TOOLS="$OPTARG" ;;
        v) VERSION="$OPTARG" ;;
        *) usage ;;
    esac
done

if [ -z "$NAME" ] || [ -z "$DESCRIPTION" ]; then
    usage
fi

# tools="a,b,c" → python list ["a","b","c"]
TOOLS_JSON=$(python3 -c "
import json, sys
tools = '$TOOLS'.split(',')
tools = [t.strip() for t in tools if t.strip()]
print(json.dumps(tools))
")

python3 - "$TARGET" "$TEMPLATE" "$NAME" "$DESCRIPTION" "$VERSION" "$TOOLS_JSON" <<'PY'
import json
import sys
from pathlib import Path

target, template, name, desc, version, tools_json = sys.argv[1:]
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from sin_mcp_server_builder import Scaffolder, ScaffoldSpec

spec = ScaffoldSpec(
    name=name,
    description=desc,
    tools=json.loads(tools_json),
    template=template,
    version=version,
)
summary = Scaffolder().scaffold(target, spec)
print(json.dumps(summary, indent=2))
PY
