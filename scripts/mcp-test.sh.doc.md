# `scripts/mcp-test.sh`

## What it does
CLI wrapper that generates pytest tests for a specific tool and runs the
full pytest suite.

## Dependencies
- `python3` (with `sin_mcp_server_builder` on `PYTHONPATH`)
- `pytest` (target project's dev dependency)
- `getopts`

## Usage
```bash
./scripts/mcp-test.sh -s ./my-mcp/src/my_mcp/mcp_server.py -n do_x -o ./my-mcp/tests/test_mcp_server.py
```

## Options
| Flag | Description | Default |
|------|-------------|---------|
| `-s` | Path to `mcp_server.py` | — |
| `-n` | Tool name | — |
| `-o` | Output test file (appends) | empty (just print) |

## Notes
- If a target test file is given, the script appends to it and then runs
  `pytest -q` in the target project root.
