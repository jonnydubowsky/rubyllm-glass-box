# 09. Tool search and an MCP App approval

Deferred tools stay out of the first request. The model asks `tool_search` to load one by name. On OpenAI's Responses API and on Anthropic, that search is a provider tool. Gemini's protocol does not provide it, so ruby_llm 2.2.3 adds a local `tool_search` tool. This step uses `gemini-3.7-flash` so you can see that local tool. The tour's card is the provider-side search, and it then shows an MCP App panel. This course does not open that panel.

The loaded tool is `catalog_note`, which `requires_approval`. You get an approval card with the title and the note. `GLASS_BOX_APPROVE=yes` approves. A non-interactive run without that variable declines. Either way the transcript shows the tool result, including an error string when the call was declined.

The tour named `pending_approvals` and `agent.approve`. This gem pauses on `pending_questions`. You call `question.approve` or `question.decline`, then `chat.complete`.

## Run

```
bin/learn run 9
ruby demos/09-tool-search/run.rb
```

Docs: https://rubyllm.com/tool-search/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
