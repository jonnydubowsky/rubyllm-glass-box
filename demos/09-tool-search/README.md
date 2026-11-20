# 09. Tool search and an MCP App approval

This demo defers its tools on `gemini-3.7-flash`. That provider has no server-side tool search, so the gem adds a local `tool_search` tool. The query `select:create_catalog_note` loads the write tool, which then waits for approval. To approve it, set `GLASS_BOX_APPROVE=yes` or type yes. The demo leaves the tour's MCP App panel closed. It approves with `question.approve`, the current name for the tour's `agent.approve`. In live mode without a Gemini key, the demo uses your default chat model, and a provider that searches on its own side makes no local `tool_search` call.

## Run

```
GLASS_BOX_MODE=offline bin/demo 09
```

You can also run `ruby demos/09-tool-search/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends chat requests to Gemini, or to your default chat model when no Gemini key is set, until the turn ends.

## What to look at

`[deferred tools]` lists the tools that the first request leaves out. The first `[tool call]` is `tool_search`, and its result names the tool it loaded. `APPROVAL NEEDED` shows the pending call and its arguments. With no terminal and no `GLASS_BOX_APPROVE`, the demo declines, and the tool message in the transcript holds `{"error":"Not approved in this run"}`.

Docs: https://rubyllm.com/tool-search/

Guided lesson: `guided/lessons/09-tool-search.md`
