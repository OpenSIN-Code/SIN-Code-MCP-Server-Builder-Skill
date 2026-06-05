# `sin_mcp_server_builder/test_gen.py`

## What it does
Inspects an existing `mcp_server.py`, finds the `@mcp.tool()` function by
name, and emits three pytest stubs: a smoke test, a parametrized test (one
row per parameter), and an error-envelope test. Output is plain text — the
caller decides where to write it.

## Dependencies
- `re` for the function signature regex
- Sibling: none

## Key classes / functions
- `TestGenerator.generate()` — main entry point.
- `_extract_params()` — pulls `(name, type)` from the function signature.
- `_sample_value()` / `_empty_value()` — internal helpers for the test
  inputs.

## Usage
```python
from sin_mcp_server_builder.test_gen import TestGenerator
from pathlib import Path
gen = TestGenerator()
code = gen.generate(Path("src/foo/mcp_server.py"), "do_x", output_path=Path("tests/test_mcp_server.py"))
```

## Caveats
- The regex is intentionally simple: it only matches `@mcp.tool()` with no
  arguments, a single-line `def name(...):`, and a standard type-annotated
  signature. Decorator variants like `@mcp.tool(name="...")` are out of
  scope for v0.1.0.
- Type strings with defaults (e.g. `name: str = "x"`) are handled; only
  the type is extracted.
