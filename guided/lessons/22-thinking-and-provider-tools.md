# 22. Extended thinking and provider web search

`with_thinking(effort: :high)` and `with_provider_tools(:web_search)` are chat settings, and you can print them before the request. On this gem, the effort value is the symbol you passed in.

Some models don't offer web search. When the gem raises `UnsupportedServerToolError` or another `RubyLLM::Error`, the step rescues the error and logs its class and message. The thinking setting stays on the chat.

Offline, the stubbed message has no citations. Under it, the step prints a recorded citation about Ruby and labels it as coming from outside this response. Keep that card separate from `response.citations`.

## Run

```
bin/learn run 22
ruby demos/22-thinking-and-provider-tools/run.rb
```

Docs: https://rubyllm.com/thinking/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
