#!/usr/bin/env bash
# Purpose: Run the test suite for a generated MCP server.
# Docs: scripts/mcp-test.sh.doc.md

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SERVER=""
TOOL_NAME=""
OUTPUT=""

usage() {
    echo "Usage: $0 -s <server.py> -n <tool_name> [-o <output.py>]"
    echo "  -s  Path to mcp_server.py"
    echo "  -n  Tool name to generate tests for"
    echo "  -o  Output test file (appends if exists)"
    exit 1
}

while getopts ":s:n:o:" opt; do
    case $opt in
        s) SERVER="$OPTARG" ;;
        n) TOOL_NAME="$OPTARG" ;;
        o) OUTPUT="$OPTARG" ;;
        *) usage ;;
    esac
done

if [ -z "$SERVER" ] || [ -z "$TOOL_NAME" ]; then
    usage
fi

# Generate tests
python3 - "$SERVER" "$TOOL_NAME" "$OUTPUT" <<'PY'
import sys
from pathlib import Path

server, tool_name, output = sys.argv[1:]
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
from sin_mcp_server_builder import TestGenerator

code = TestGenerator().generate(
    Path(server),
    tool_name,
    Path(output) if output else None,
)
print(code)
PY

# Run the test suite for the current repo (or target dir)
TARGET_DIR="${SERVER%/src/*}/tests"
if [ -d "$TARGET_DIR" ]; then
    cd "$(dirname "$SERVER")/.."
    python3 -m pytest -q
fi
