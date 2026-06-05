# `tests/test_validator.py`

## What it does
Unit tests for the static validator. Covers docstring / type hint checks,
CoDocs detection, and the project structure checks (`pyproject.toml`,
`tests/`).

## Dependencies
- `pytest`
- `sin_mcp_server_builder.validator`

## Usage
```bash
pytest tests/test_validator.py -q
```
