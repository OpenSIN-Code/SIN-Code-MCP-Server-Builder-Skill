# `sin_mcp_server_builder/publisher.py`

## What it does
Builds and publishes an MCP server to its package registry. Supports the
three built-in templates:

- `python-fastmcp` → `python -m build` + `twine upload` (PyPI / TestPyPI).
- `node-mcp` → `npm publish`.
- `go-mcp` → no central registry; emits guidance to tag the repo.

## Dependencies
- `subprocess` (stdlib) for `python -m build`, `twine`, `npm publish`.
- `shutil.which` (stdlib) for command existence checks.
- Sibling: none

## Key classes / functions
- `Publisher` — main class. `dry_run=True` skips the actual upload (CI
  smoke-test friendly). `timeout` bounds subprocess calls.
- `publish_pypi()` / `publish_npm()` / `publish_go()` — one method per
  registry.
- `publish()` — dispatcher that picks the right method from the template
  key.
- `_read_pyproject()` — lightweight TOML reader; avoids the `tomllib`
  stdlib requirement (Python < 3.11).

## Usage
```python
from sin_mcp_server_builder.publisher import Publisher
result = Publisher(dry_run=True).publish(Path("./my-mcp"), template="python-fastmcp")
print(result.to_dict())
```

## Caveats
- Credentials are NOT stored or injected. The publisher expects
  `TWINE_USERNAME` / `TWINE_PASSWORD` (or `.pypirc`) for PyPI and
  `NPM_TOKEN` for npm.
- `_read_pyproject()` does not handle multi-line arrays / table headers
  beyond the `[project]` section. `[tool.poetry]` style is not supported.
- The npm registry URL default is the public registry; pass a custom URL
  for a private registry.
