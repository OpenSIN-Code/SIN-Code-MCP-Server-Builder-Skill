# `sin_mcp_server_builder/registrar.py`

## What it does
Reads, mutates, and writes `opencode.json` to register/unregister MCP servers.
Pure stdlib (`json` + `pathlib`) — preserves `$schema`, key order, and
unknown fields. Tolerates JSONC-style comments for the common opencode.jsonc
format.

## Dependencies
- `json` (stdlib)
- `pathlib` (stdlib)
- Sibling: none

## Key classes / functions
- `McpServerEntry` — small dataclass; `to_json()` returns the dict for the
  `mcp.<name>` slot.
- `Registrar` — main class. `config_path` is auto-discovered but can be
  overridden. `register()` is the workhorse.
- `build_local_entry()` — module-level helper for the common "local stdio
  server" case.

## Usage
```python
from sin_mcp_server_builder.registrar import Registrar, build_local_entry
entry = build_local_entry(
    "my-tool",
    command=["uvx", "my-tool-mcp"],
    env={"API_KEY": "dummy"},
)
path = Registrar().register(entry)
print(f"Registered in {path}")
```

## Caveats
- The registrar does NOT restart opencode. The user must quit and relaunch
  for the new MCP server to load.
- `OPENCODE_CONFIG` env var is respected, matching opencode's own loader.
- `_strip_jsonc()` is a *lightweight* JSONC parser — it does not handle
  every edge case (e.g. comments inside string literals). Round-tripping
  exotic JSONC is out of scope.
