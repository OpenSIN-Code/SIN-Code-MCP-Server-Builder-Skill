# `sin_mcp_server_builder/templates.py`

## What it does
Owns the Jinja2 template engine used by the scaffolder and exposes a registry
of the three built-in MCP server templates (`python-fastmcp`, `node-mcp`,
`go-mcp`). `render_file()` uses jinja2 when available, `render_to_string()`
is a pure-Python fallback for tests.

## Dependencies
- `jinja2` (optional — only required by `render_file`)
- `pathlib` for filesystem traversal
- Sibling: none (this module is the source of truth for template metadata)

## Key classes / functions
- `TemplateEngine` — the engine. `templates_dir` is overridable for tests.
- `list_templates()` — module-level convenience that returns a list of dicts.
- `TEMPLATE_REGISTRY` — the canonical list. Adding a new template = one entry
  here plus a folder under `templates/`.

## Usage
```python
from sin_mcp_server_builder.templates import TemplateEngine
engine = TemplateEngine()
for tpl in engine.list_templates():
    print(tpl["name"])
text = engine.render_to_string("python-fastmcp", "pyproject.toml", {"name": "x"})
```

## Caveats
- `render_file()` raises at import if jinja2 is not installed — only call it
  when jinja2 is a guaranteed dep. `render_to_string()` is the safe fallback.
- Template names are validated against the registry, not the filesystem, so
  a typo fails fast with a clear message.
