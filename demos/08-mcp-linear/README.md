# 08. An MCP server declared as a Ruby class

This demo declares `Linear < RubyLLM::MCP` with the current DSL, using `url`, `inputs`, `oauth`, `only`, `requires_approval` and `extension :apps`, and never connects to Linear. It then opens `CatalogMCP`, a local transport, and calls `list_titles` for Lantern Reel. The `create_note` tool needs approval, and the demo never calls it.

## Run

```
GLASS_BOX_MODE=offline bin/demo 08
```

You can also run `ruby demos/08-mcp-linear/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/mcp/

Guided lesson: `guided/lessons/08-mcp-linear.md`
