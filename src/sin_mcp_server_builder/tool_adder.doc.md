# `sin_mcp_server_builder/tool_adder.py`

## What it does
Appends a new `@mcp.tool()` function to an existing `mcp_server.py` *without*
breaking CoDocs structure. Also writes a matching pytest stub into the
companion test file. Conservative string surgery: never touches `.doc.md`
files, never rewrites existing tools.

## Dependencies
- `re` for the two regexes (last `@mcp.tool()` block, `FastMCP(` declaration)
- Sibling: none

## Key classes / functions
- `ToolSpec` — declarative spec for the new tool (name, params, body, etc.).
- `ToolAdder` — the workhorse. `add_to_python()` and `add_test()` are the
  two public methods.
- `_sample_value()` — internal helper for the generated pytest args.

## Usage
```python
from sin_mcp_server_builder.tool_adder import ToolAdder, ToolSpec
spec = ToolSpec(
    name="do_x",
    description="Perform operation X.",
    params=[("input", "str", '""')],
)
adder = ToolAdder()
adder.add_to_python(Path("src/foo/mcp_server.py"), spec)
adder.add_test(Path("tests/test_mcp_server.py"), spec)
```

## Caveats
- The adder assumes a `@mcp.tool()` decorator form. `@mcp.tool(name="...")`
  variants still work because the regex matches `@mcp.tool(`.
- The append is *destructive* — it rewrites the file. Always have a git
  working copy before running.
- Only Python FastMCP is supported; Node/Go require their own adder (out of
  scope for v0.1.0).
