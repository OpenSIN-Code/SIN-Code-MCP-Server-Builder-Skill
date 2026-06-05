# `sin_mcp_server_builder/validator.py`

## What it does
Static-analyzes an MCP server source tree. It collects:
- A list of all `@mcp.tool()`-decorated functions.
- Errors: tools missing a docstring, syntax errors in any `.py` file,
  missing `tests/` directory.
- Warnings: missing type hints, missing return hints, missing CoDocs
  companion file.
- Info: missing `pyproject.toml`.

## Dependencies
- `ast` (stdlib) for parsing Python source.
- `re` (stdlib) for the docstring regex.
- Sibling: none

## Key classes / functions
- `ValidationIssue` — single finding (level / code / message / file / line).
- `ValidationResult` — aggregate; `.ok` is True when no `error` issues.
- `Validator.validate()` — the workhorse.

## Usage
```python
from sin_mcp_server_builder.validator import Validator
result = Validator().validate(Path("./my-mcp-server"))
if not result.ok:
    for issue in result.issues:
        print(issue.level, issue.code, issue.message)
```

## Caveats
- The validator does not import the module — pure AST inspection. This
  keeps it safe to run on untrusted code, but it cannot detect runtime
  issues (e.g. a tool that calls a missing dependency).
- CoDocs check expects a sibling `<file>.doc.md` next to every `.py` under
  `src/`. `__init__.py` is checked too — relax this if your project
  allows package-level docs in the parent's `.doc.md`.
