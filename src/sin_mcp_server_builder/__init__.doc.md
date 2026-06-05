# `sin_mcp_server_builder/__init__.py`

## What it does
Package entry point for the SIN-Code MCP-Server-Builder Skill. Exposes the
eight core building blocks that the FastMCP server wires up as tools:
`scaffolder`, `templates`, `tool_adder`, `test_gen`, `registrar`, `validator`,
`publisher`, `auditor`.

## Dependencies
- All sibling modules in this package
- `fastmcp` (consumer side, not imported here)

## Usage
```python
from sin_mcp_server_builder import Scaffolder, ScaffoldSpec
spec = ScaffoldSpec(name="my-tool", description="...", tools=["do_x"])
Scaffolder().scaffold("./out", spec)
```

## Notes
- `__version__` is the canonical source of truth for the package version.
- Keep `__all__` in sync with public API additions.
