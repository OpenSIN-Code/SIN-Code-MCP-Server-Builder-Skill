# SIN-Code-MCP-Server-Builder-Skill — Agent Instructions

## What this repo is

The **meta-skill** for scaffolding new MCP servers in the OpenSIN-Code ecosystem. 8 FastMCP tools, 113 tests, 100% CoDocs, 3 templates (python-fastmcp, node-mcp, go-mcp).

## ⚠️ CoDocs-Pflicht

Jede `.py` Datei hat eine `.doc.md` Partner-Datei im selben Verzeichnis. Vor jedem Commit verifizieren:

```bash
# Manual check
ls src/sin_mcp_server_builder/*.doc.md
ls tests/*.doc.md
```

## Tools

- `sin-mcp-server-builder-mcp` — FastMCP server (stdio transport)
- `scripts/mcp-*.sh` — CLI wrappers
- `pytest` — Test runner

## Commits

- Conventional Commits (`feat:`, `fix:`, `test:`, `docs:`, `chore:`, `refactor:`)
- Direkt auf `main` — keine Branches
- Push am Ende jeder Session

## Testing

```bash
pytest -q
```

Alle 113 Tests müssen grün sein vor dem Push.

## CI

- `.github/workflows/ceo-audit.yml` läuft bei jedem Push
- Grade gate: B
- Secret: `SIN_GITHUB_FALLBACK_TOKEN`

## Adding a new template

1. Add a folder under `templates/<name>/`
2. Add an entry to `TEMPLATE_REGISTRY` in `src/sin_mcp_server_builder/templates.py`
3. Add tests in `tests/test_templates.py`
4. Update `README.md` and `SKILL.md`
5. Add `CoDocs` for any new module

## Public API

The 8 FastMCP tools in `mcp_server.py` are the public API. Adding a new tool = one `@mcp.tool()` decorator + a test in `tests/test_mcp_server.py`.
