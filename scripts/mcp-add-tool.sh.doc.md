# `scripts/mcp-add-tool.sh`

## What it does
CLI wrapper for the `mcp_tool_add` MCP tool. Appends a new
`@mcp.tool()`-decorated function to an existing `mcp_server.py`,
preserving CoDocs and existing tools.

## Dependencies
- `python3` (with `sin_mcp_server_builder` on `PYTHONPATH`)
- `getopts`

## Usage
```bash
./scripts/mcp-add-tool.sh \
    -s ./my-mcp/src/my_mcp/mcp_server.py \
    -n do_x \
    -d "Perform operation X." \
    -p '[["input", "str", "\"\""]]'
```

## Options
| Flag | Description | Default |
|------|-------------|---------|
| `-s` | Path to `mcp_server.py` | — |
| `-n` | Tool name | — |
| `-d` | Tool description | — |
| `-p` | JSON list of `[name, type, default]` tuples | `[]` |
| `-b` | Python body | `result = {"ok": True}` |

## Notes
- The tool adder rewrites the file. Always have a git working copy.
