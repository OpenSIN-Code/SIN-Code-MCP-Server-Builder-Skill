# `scripts/mcp-scaffold.sh`

## What it does
CLI wrapper for the `mcp_scaffold` MCP tool. Reads CLI flags, builds a
`ScaffoldSpec` in Python, and invokes `Scaffolder().scaffold()`.

## Dependencies
- `python3` (with `sin_mcp_server_builder` on `PYTHONPATH` via `src/`)
- `getopts` (bash built-in)

## Usage
```bash
./scripts/mcp-scaffold.sh -n "My Tool" -d "Does cool things" -T python-fastmcp -o "do_x,do_y"
```

## Options
| Flag | Description | Default |
|------|-------------|---------|
| `-n` | Server name (e.g. "My Cool Tool") | — |
| `-d` | One-line description | — |
| `-t` | Target directory | `./out` |
| `-T` | Template (`python-fastmcp`/`node-mcp`/`go-mcp`) | `python-fastmcp` |
| `-o` | Comma-separated tool names | `ping` |
| `-v` | Initial semver version | `0.1.0` |

## Notes
- The script refuses to write into a non-empty target directory (the
  Scaffolder raises `FileExistsError`).
