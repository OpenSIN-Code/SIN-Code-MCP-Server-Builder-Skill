# `tests/test_publisher.py`

## What it does
Unit tests for `Publisher`, covering the dispatcher (`publish()`),
the per-template methods (`publish_pypi`, `publish_npm`, `publish_go`),
and the TOML/JSON readers.

## Dependencies
- `pytest`
- `sin_mcp_server_builder.publisher`

## Usage
```bash
pytest tests/test_publisher.py -q
```
