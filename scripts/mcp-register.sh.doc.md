# `scripts/mcp-register.sh`

## What it does
CLI wrapper for the `mcp_register` MCP tool. Adds an MCP server entry
to `opencode.json` (or `opencode.jsonc`).

## Dependencies
- `python3` (with `sin_mcp_server_builder` on `PYTHONPATH`)
- `getopts`

## Usage
```bash
./scripts/mcp-register.sh -n my-tool -c "uvx my-tool-mcp" -E '{"API_KEY": "dummy"}'
```

## Options
| Flag | Description | Default |
|------|-------------|---------|
| `-n` | Server name (mcp section key) | — |
| `-c` | Command + args (space-separated) | — |
| `-e` | Disable the server | enabled by default |
| `-E` | JSON env vars object | `{}` |
| `-C` | Path to `opencode.json` | auto-discover |

## Notes
- After registering, restart opencode for the new server to load.
- `OPENCODE_CONFIG` env var is honored by the underlying Registrar.
