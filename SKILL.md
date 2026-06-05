---
name: sin-mcp-server-builder
description: "MCP Server Builder — meta-skill that scaffolds new MCP servers (python-fastmcp / node-mcp / go-mcp). 8 tools: scaffold, template_list, add_tool, test, register, validate, publish, audit."
version: 0.1.0
category: meta
requirements:
  - Python >= 3.10
  - fastmcp >= 0.3.0
  - jinja2 >= 3.0.0
---

# SIN-MCP-Server-Builder Skill

Meta-skill for scaffolding new MCP servers in the OpenSIN-Code ecosystem. Use this when you need to create a new MCP server from scratch — the skill encodes the canonical OpenSIN-Code pattern: `pyproject.toml` + `src/<pkg>/mcp_server.py` + `tests/` + `*.doc.md` + `ceo-audit.yml`.

## When to use

- "Scaffold a new MCP server" / "Create a new MCP tool" / "Generate MCP project"
- "I need a new FastMCP server with tools X, Y, Z"
- "Build me a Node.js MCP SDK project"
- "Add a tool to my existing MCP server"
- "Validate / publish / audit my MCP server"

## Commands

```bash
# MCP server (stdio transport)
sin-mcp-server-builder-mcp

# CLI scripts
./scripts/mcp-scaffold.sh -n "My Tool" -d "..." -T python-fastmcp -o "do_x,do_y"
./scripts/mcp-add-tool.sh -s ./my-mcp/src/mcp_server.py -n do_z -d "..."
./scripts/mcp-test.sh -s ./my-mcp/src/mcp_server.py -n do_x -o ./my-mcp/tests/test_mcp_server.py
./scripts/mcp-register.sh -n my-tool -c "uvx my-tool-mcp"
./scripts/mcp-validate.sh ./my-mcp
./scripts/mcp-publish.sh -p ./my-mcp -T python-fastmcp -d false
```

## MCP Tools

| Tool | Parameters | Returns |
|------|-----------|---------|
| `mcp_scaffold` | name, description, target, tools, template | summary dict |
| `mcp_template_list` | — | list of template metadata |
| `mcp_tool_add` | server_path, tool_name, description, params, body | rendered tool source |
| `mcp_tool_test` | server_path, tool_name, output_path | generated pytest code |
| `mcp_register` | name, command, enabled, env, config_path | registered entry + path |
| `mcp_validate` | project_dir | validation report |
| `mcp_publish` | project_dir, template, test, dry_run, registry | publish result |
| `mcp_audit` | project_dir, grade, profile | audit report |

## Templates

| Key | Stack | Entry point |
|-----|-------|-------------|
| `python-fastmcp` | Python + FastMCP | `src/<pkg>/mcp_server.py` |
| `node-mcp` | Node.js + `@modelcontextprotocol/sdk` | `src/index.js` |
| `go-mcp` | Go + `github.com/modelcontextprotocol/go-sdk` | `main.go` |

## Installation

```bash
git clone https://github.com/OpenSIN-Code/SIN-Code-MCP-Server-Builder-Skill.git
cd SIN-Code-MCP-Server-Builder-Skill
pip install -e ".[dev]"
```

## Usage Example

### Scaffold + Validate + Audit a new server

```python
# Via MCP
mcp_scaffold(
    name="My Tool",
    description="A new MCP server.",
    target="./my-tool",
    tools="do_x,do_y,do_z",
    template="python-fastmcp",
)
mcp_validate("./my-tool")
mcp_audit("./my-tool")
```

### CLI equivalent

```bash
./scripts/mcp-scaffold.sh -n "My Tool" -d "..." -o "do_x,do_y" -t ./my-tool
./scripts/mcp-validate.sh ./my-tool
```

## CoDocs

Every `.py` file has a sibling `.doc.md` companion in the same directory.

## License

MIT — OpenSIN-Code
