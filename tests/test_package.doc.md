# `tests/test_package.py`

## What it does
Smoke tests for the top-level `sin_mcp_server_builder` package — every
public export resolves, the version is set, and every module imports.

## Dependencies
- `pytest`
- `sin_mcp_server_builder`

## Usage
```bash
pytest tests/test_package.py -q
```
