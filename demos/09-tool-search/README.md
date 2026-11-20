# 09. Tool search and an MCP App approval

This demo defers its tools on `gemini-3.7-flash`. That provider has no server-side tool search, so the gem adds a local `tool_search` tool. The query `select:create_catalog_note` loads the write tool, which then waits for approval. To approve it, set `GLASS_BOX_APPROVE=yes` or type yes. The demo leaves the tour's MCP App panel closed. It approves with `question.approve`, the current name for the tour's `agent.approve`.

## Run

```
GLASS_BOX_MODE=offline bin/demo 09
```

You can also run `ruby demos/09-tool-search/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/tool-search/

Guided lesson: `guided/lessons/09-tool-search.md`
