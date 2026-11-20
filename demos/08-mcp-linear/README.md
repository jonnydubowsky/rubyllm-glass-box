# 08. An MCP server declared as a Ruby class

This demo declares `Linear < RubyLLM::MCP` with the current DSL, using `url`, `inputs`, `oauth`, `only`, `requires_approval` and `extension :apps`, and never connects to Linear. It then opens `CatalogMCP`, a local transport, and calls `list_titles` for Lantern Reel. The `create_note` tool needs approval, and the demo never calls it.

## Run

```
GLASS_BOX_MODE=offline bin/demo 08
```

You can also run `ruby demos/08-mcp-linear/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

This demo calls no provider and no remote server in any mode.

## What to look at

`[Linear.only]` lists the three tools the model could see. `[Linear approvals]` shows that `create_issue` waits for a person. `[fixture server tools]` and `[list_titles result]` come from the local catalog server, the only server this demo talks to.

Docs: https://rubyllm.com/mcp/

Guided lesson: `guided/lessons/08-mcp-linear.md`
