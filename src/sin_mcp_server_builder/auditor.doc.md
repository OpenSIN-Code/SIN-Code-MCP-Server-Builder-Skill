# `sin_mcp_server_builder/auditor.py`

## What it does
Runs a ceo-audit (47 quality gates) on a freshly scaffolded MCP server.
Wraps the `sin ceo-audit run <path>` CLI and parses its JSON output into
an `AuditReport`. If `sin` is not installed and `install_if_missing=True`,
the auditor will `pip install sin-code-bundle[ceo-audit]` first.

## Dependencies
- `subprocess` (stdlib) for the CLI invocation.
- `shutil.which` (stdlib) for the `sin` binary lookup.
- Sibling: none

## Key classes / functions
- `Auditor` — the workhorse. `grade` / `profile` defaults match the
  scheduler-skill workflow (B / QUICK).
- `AuditReport` — aggregate result with grade, score, gate counts, and a
  raw output string for debugging.

## Usage
```python
from sin_mcp_server_builder.auditor import Auditor
report = Auditor().audit(Path("./my-new-mcp"))
print(report.to_dict())
```

## Caveats
- The CEO-audit can be slow (47 gates → ~3-5 minutes on a small repo).
  The default `timeout=600` seconds is generous but you may need to bump
  it for larger projects.
- The JSON parser is best-effort: if `sin` emits a non-JSON summary (older
  versions), the auditor returns a `?` grade with the raw output
  preserved.
- Running an audit mutates the environment by installing the
  `sin-code-bundle[ceo-audit]` package when not present. Set
  `install_if_missing=False` in CI sandboxes.
