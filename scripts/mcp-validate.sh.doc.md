# `scripts/mcp-validate.sh`

## What it does
CLI wrapper for the `mcp_validate` MCP tool. Runs the static validator
against a project directory and exits 0 when there are no `error`-level
issues.

## Dependencies
- `python3` (with `sin_mcp_server_builder` on `PYTHONPATH`)

## Usage
```bash
./scripts/mcp-validate.sh ./my-new-mcp
```

## Exit codes
| Code | Meaning |
|------|---------|
| 0 | No errors (warnings/info OK) |
| 1 | One or more errors found |

## Notes
- Pure static analysis — no imports of the target module.
