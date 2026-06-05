# `sin_mcp_server_builder/scaffolder.py`

## What it does
Materializes a new MCP server directory tree from a `ScaffoldSpec`. Picks the
right template (`python-fastmcp`, `node-mcp`, `go-mcp`) and renders every
file using the `TemplateEngine`. Files that look like templates (`.j2` or
contain `{{ ... }}`) go through Jinja2; everything else is copied verbatim.

## Dependencies
- `pathlib` for filesystem ops
- `jinja2` (only when a template file actually uses it)
- Sibling: `templates.py`

## Key classes / functions
- `ScaffoldSpec` — declarative spec; the dataclass `__post_init__` validates
  the template choice and tool names.
- `Scaffolder` — the workhorse. `scaffold()` is the real call;
  `dry_run()` returns a preview without writing.
- `slugify()` / `package_name()` — shared naming helpers.

## Usage
```python
from sin_mcp_server_builder.scaffolder import Scaffolder, ScaffoldSpec
spec = ScaffoldSpec(name="My Tool", tools=["do_x"], template="python-fastmcp")
summary = Scaffolder().scaffold("./out", spec)
print(summary["files"])
```

## Caveats
- The scaffolder does NOT run `git init`, install deps, or commit. The caller
  (usually the bash script) handles the post-scaffold wiring.
- If `target_dir` exists and is non-empty, `scaffold()` raises
  `FileExistsError` to prevent clobbering an existing repo.
