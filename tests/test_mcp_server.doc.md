# `tests/test_mcp_server.py`

## What it does
Smoke tests for every FastMCP tool exposed by `sin_mcp_server_builder`.
Each test calls the tool function directly (FastMCP tools are plain
Python callables) and parses the JSON envelope.

## Dependencies
- `pytest`
- `sin_mcp_server_builder.mcp_server`

## Usage
```bash
pytest tests/test_mcp_server.py -q
```
