# SIN-Code-MCP-Server-Builder-Skill

[![MCP](https://img.shields.io/badge/MCP-server-blue)](https://modelcontextprotocol.io)
[![CEO Audit](https://img.shields.io/badge/CEO_Audit-passing-success)](.github/workflows/ceo-audit.yml)
[![CoDocs](https://img.shields.io/badge/CoDocs-100%25-success)](src/sin_mcp_server_builder)

> **Meta-skill that scaffolds new MCP servers** for the OpenSIN-Code ecosystem. Supports `python-fastmcp`, `node-mcp`, and `go-mcp` templates — 8 FastMCP tools, 113 tests, 100% CoDocs.

## What it does

The OpenSIN-Code ecosystem runs **30+ MCP servers** (sin-websearch, sin-scheduler, sin-marketplace, sin-slash, sin-goal-mode, sin-infisical, …). Every one of them followed the same canonical pattern: `pyproject.toml` + `src/<pkg>/mcp_server.py` + `tests/` + `*.doc.md` + `ceo-audit.yml`. This meta-skill codifies that pattern — give it a name + a list of tools and you get a fully scaffolded, CoDocs-compliant, ceo-audit-ready MCP server in one tool call.

## Features

- **3 templates** — `python-fastmcp` (FastMCP), `node-mcp` (official SDK), `go-mcp` (go-sdk)
- **8 FastMCP tools** — scaffold, template_list, add_tool, test, register, validate, publish, audit
- **113 tests** covering scaffolding, template rendering, tool addition, test generation, registration, validation, MCP server
- **100% CoDocs** — every `.py` has a sibling `.doc.md`
- **6 bash scripts** — `mcp-scaffold.sh`, `mcp-add-tool.sh`, `mcp-test.sh`, `mcp-register.sh`, `mcp-validate.sh`, `mcp-publish.sh`
- **ceo-audit** workflow with grade gate B

## Quick Start

```bash
git clone https://github.com/OpenSIN-Code/SIN-Code-MCP-Server-Builder-Skill.git
cd SIN-Code-MCP-Server-Builder-Skill
pip install -e ".[dev]"
```

### Run the MCP server

```bash
sin-mcp-server-builder-mcp
# or
python -m sin_mcp_server_builder.mcp_server
```

### Scaffold a new MCP server

```bash
./scripts/mcp-scaffold.sh -n "My Tool" -d "Does cool things" -T python-fastmcp -o "do_x,do_y"
```

### Validate a freshly scaffolded server

```bash
./scripts/mcp-validate.sh ./my-new-tool
```

## MCP Tools

| Tool | Purpose |
|------|---------|
| `mcp_scaffold` | Scaffold a new MCP server from a spec |
| `mcp_template_list` | List available templates |
| `mcp_tool_add` | Add a new tool to an existing MCP server (preserves CoDocs) |
| `mcp_tool_test` | Generate pytest tests for a tool |
| `mcp_register` | Register the server in `opencode.json` |
| `mcp_validate` | Validate tools (type hints, docstrings, CoDocs) |
| `mcp_publish` | Publish to PyPI / npm |
| `mcp_audit` | Run ceo-audit (47 quality gates) |

## Architecture

```
MCP Client (OpenCode, Claude, …)
    ↓ FastMCP (stdio)
mcp_server.py
    ↓
┌──────────────────────────────────────────────┐
│ Scaffolder   │ ToolAdder   │ TestGenerator   │
│ Templates    │ Registrar   │ Validator       │
│ Publisher    │ Auditor                          │
└──────────────────────────────────────────────┘
    ↓
┌──────────────────────────────────────────────┐
│ python-fastmcp / node-mcp / go-mcp templates  │
│ (CoDocs + ceo-audit.yml + tests + scripts)   │
└──────────────────────────────────────────────┘
```

## Project Structure

```
SIN-Code-MCP-Server-Builder-Skill/
├── src/sin_mcp_server_builder/
│   ├── __init__.py        — Package entry, public API
│   ├── mcp_server.py      — FastMCP server (8 tools)
│   ├── scaffolder.py      — Scaffold new servers from a spec
│   ├── templates.py       — Jinja2 engine + template registry
│   ├── tool_adder.py      — Add tools to existing servers
│   ├── test_gen.py        — Generate pytest tests
│   ├── registrar.py       — Update opencode.json
│   ├── validator.py       — Static validator (47 gates subset)
│   ├── publisher.py       — PyPI / npm publish
│   └── auditor.py         — ceo-audit runner
├── templates/
│   ├── python-fastmcp/    — Python + FastMCP
│   ├── node-mcp/          — Node.js + @modelcontextprotocol/sdk
│   └── go-mcp/            — Go + go-sdk
├── scripts/               — Bash CLI wrappers
├── tests/                 — 113 tests
├── .github/workflows/ceo-audit.yml
├── pyproject.toml
├── README.md
├── SKILL.md
└── AGENTS.md
```

## Testing

```bash
pytest -q
pytest --cov=src/sin_mcp_server_builder --cov-report=term-missing
```

## CoDocs

Every `.py` file has a sibling `.doc.md` companion. Run `sin codocs check` to verify.

## CI

The `ceo-audit.yml` workflow runs on every push to `main` and:
1. Installs the package + dev deps
2. Runs `pytest -q`
3. Lints with `black` + `ruff`
4. Type-checks with `mypy`
5. Runs `sin ceo-audit run . --profile=QUICK --grade=B`

## License

MIT — OpenSIN-Code
