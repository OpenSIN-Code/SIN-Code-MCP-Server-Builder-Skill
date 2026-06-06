#!/usr/bin/env bash
# Purpose: Publish an MCP server to PyPI or npm.
# Docs: mcp-publish.sh.doc.md

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PROJECT_DIR="."
TEMPLATE="python-fastmcp"
TEST=false
DRY_RUN=true
REGISTRY=""

usage() {
    echo "Usage: $0 -p <project_dir> -T <template> [-t] [-d false] [-r <registry>]"
    echo "  -p  Project directory (default: .)"
    echo "  -T  Template: python-fastmcp|node-mcp|go-mcp (default: python-fastmcp)"
    echo "  -t  Publish to TestPyPI (Python only)"
    echo "  -d  Dry-run (default: true). Pass 'false' to actually publish."
    echo "  -r  npm registry URL (Node only)"
    exit 1
}

while getopts ":p:T:t:d:r:" opt; do
    case $opt in
        p) PROJECT_DIR="$OPTARG" ;;
        T) TEMPLATE="$OPTARG" ;;
        t) TEST=true ;;
        d) DRY_RUN="$OPTARG" ;;
        r) REGISTRY="$OPTARG" ;;
        *) usage ;;
    esac
done

python3 - "$PROJECT_DIR" "$TEMPLATE" "$TEST" "$DRY_RUN" "$REGISTRY" <<'PY'
import json
import sys
from pathlib import Path

project_dir, template, test, dry_run, registry = sys.argv[1:]
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
from sin_mcp_server_builder import Publisher

kwargs = {"test": (test.lower() == "true")}
if registry:
    kwargs["registry"] = registry
pub = Publisher(dry_run=(dry_run.lower() == "true"))
result = pub.publish(Path(project_dir), template=template, **kwargs)
print(json.dumps(result.to_dict(), indent=2))
sys.exit(0 if result.ok else 1)
PY
