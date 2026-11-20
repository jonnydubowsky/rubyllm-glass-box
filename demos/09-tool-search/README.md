# 09. Tool search and an MCP App approval

Deferred tools on `gemini-3.7-flash`, because that provider does not do server-side tool search, so the gem adds local `tool_search`. The query `select:create_catalog_note` loads the write tool, which waits on approval. Approve with `GLASS_BOX_APPROVE=yes` or by typing yes. The tour's MCP App panel is not opened. Approval is `question.approve`, not `agent.approve`.

## Run

```
ruby demos/09-tool-search/run.rb
```

Or `bin/demo 09`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/tool-search/

Guided lesson: `guided/lessons/09-tool-search.md`
