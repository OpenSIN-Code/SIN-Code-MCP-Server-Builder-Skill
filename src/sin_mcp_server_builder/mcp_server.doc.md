# `sin_mcp_server_builder/mcp_server.py`

## What it does
FastMCP server that exposes eight meta-tools to MCP clients. Each tool
delegates to the corresponding module in this package — the server is a
thin transport adapter, not a place for business logic.

## Dependencies
- `fastmcp` for the MCP framework
- All sibling modules (`scaffolder`, `templates`, `tool_adder`, `test_gen`,
  `registrar`, `validator`, `publisher`, `auditor`)

## Tools exposed
| Tool | Purpose |
|------|---------|
| `mcp_scaffold` | Scaffold a new MCP server from a spec |
| `mcp_template_list` | List available templates (python-fastmcp, node-mcp, go-mcp) |
| `mcp_tool_add` | Add a new `@mcp.tool()` to an existing server |
| `mcp_tool_test` | Generate pytest tests for a tool |
| `mcp_register` | Register the server in `opencode.json` |
| `mcp_validate` | Validate tools (type hints, docstrings, CoDocs) |
| `mcp_publish` | Publish to PyPI / npm |
| `mcp_audit` | Run ceo-audit (47 quality gates) |

## Usage
```bash
python -m sin_mcp_server_builder.mcp_server
# or via the entry point: sin-mcp-server-builder-mcp
```

## Environment
- `OPENCODE_CONFIG` — optional override of the opencode.json path used by
  `mcp_register`.

## Notes
- All tool parameters are JSON-serialized strings for MCP wire compatibility.
- `mcp_publish` defaults to `dry_run=True` so a misconfigured MCP client
  cannot accidentally publish a package.
