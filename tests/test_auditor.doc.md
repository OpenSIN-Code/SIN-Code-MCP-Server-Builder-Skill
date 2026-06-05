# `tests/test_auditor.py`

## What it does
Unit tests for the auditor. The audit end-to-end needs the `sin` CLI;
without it, the tests cover the degraded-report path and the JSON parse
helper.

## Dependencies
- `pytest`
- `sin_mcp_server_builder.auditor`

## Usage
```bash
pytest tests/test_auditor.py -q
```
