# 09. Tool search and an MCP App approval

Deferred tools are left out of the first request. When the model needs one, it asks `tool_search` to load it by name. OpenAI's Responses API and Anthropic run that search as a provider tool. Gemini's protocol has no such tool, so ruby_llm 2.2.3 adds a local `tool_search` tool, and this step uses `gemini-3.7-flash` to show it. The tour's card shows the provider-side search followed by an MCP App panel, and this course never opens that panel.

The loaded tool is `catalog_note`, which `requires_approval`. The step shows an approval card with the title and the note. `GLASS_BOX_APPROVE=yes` approves the call, and a run with no terminal and no such variable declines it. In both cases the transcript shows the tool result, which holds an error string when the call was declined.

The tour named `pending_approvals` and `agent.approve`. This gem pauses on `pending_questions`. You call `question.approve` or `question.decline`, and then you call `chat.complete`.

## Run

```
bin/learn run 9
ruby demos/09-tool-search/run.rb
```

Docs: https://rubyllm.com/tool-search/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
