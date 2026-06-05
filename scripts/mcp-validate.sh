#!/usr/bin/env bash
# Purpose: Validate an MCP server (tools, type hints, docstrings, CoDocs).
# Docs: scripts/mcp-validate.sh.doc.md

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PROJECT_DIR="${1:-.}"

python3 - "$PROJECT_DIR" <<'PY'
import json
import sys
from pathlib import Path

project_dir = sys.argv[1]
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
from sin_mcp_server_builder import Validator

result = Validator().validate(Path(project_dir))
data = result.to_dict()
print(json.dumps(data, indent=2))
sys.exit(0 if data["ok"] else 1)
PY
