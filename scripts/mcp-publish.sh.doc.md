# `scripts/mcp-publish.sh`

## What it does
CLI wrapper for the `mcp_publish` MCP tool. Defaults to `dry_run=true` so
a misconfigured shell cannot accidentally publish.

## Dependencies
- `python3` (with `sin_mcp_server_builder` on `PYTHONPATH`)
- `twine` (Python) or `npm` (Node) for actual publishing

## Usage
```bash
# Dry-run (default)
./scripts/mcp-publish.sh -p ./my-mcp -T python-fastmcp

# TestPyPI
./scripts/mcp-publish.sh -p ./my-mcp -T python-fastmcp -t

# Real publish
./scripts/mcp-publish.sh -p ./my-mcp -T python-fastmcp -d false

# npm with custom registry
./scripts/mcp-publish.sh -p ./my-mcp -T node-mcp -r https://npm.example.com
```

## Notes
- Credentials are NOT managed by the script. Use `TWINE_USERNAME` /
  `TWINE_PASSWORD` for PyPI and `NPM_TOKEN` for npm.
- For Go projects, the publisher returns an instructional message (no
  central registry).
