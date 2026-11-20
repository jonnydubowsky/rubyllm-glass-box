# 08. An MCP server declared as a Ruby class

Declares `Linear < RubyLLM::MCP` with the current DSL (`url`, `inputs`, `oauth`, `only`, `requires_approval`, `extension :apps`) and does not connect. Then opens `CatalogMCP`, a local transport, and calls `list_titles` for Lantern Reel. `create_note` stays behind approval and is not invoked.

## Run

```
ruby demos/08-mcp-linear/run.rb
```

Or `bin/demo 08`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/mcp/

Guided lesson: `guided/lessons/08-mcp-linear.md`
