# 22. Extended thinking and provider web search

## The concept

`with_thinking(effort: :high)` asks a model that supports extended thinking to reason at length before it answers. On this gem, `chat.thinking` returns the effort as the symbol you passed in. `with_provider_tools(:web_search)` lets the provider run a web search on its own servers during the turn. Both are chat settings, and you can print them before the request. A reply that used web search can carry its sources in `response.citations`.

## What this step does

The step sets both options, prints them and asks: "In one sentence, what is a micro-drama?" Some models don't offer web search. When the gem raises `UnsupportedServerToolError`, the step rescues the error and logs its class and message, and the thinking setting stays on the chat.

Offline, the stubbed reply has no citations. Under it, the step prints a recorded citation about Ruby and labels it as coming from outside this response.

## What to look at

Read `[thinking]` and `[provider tools]` to see the settings on the chat. Then read `[citations]`. Keep the recorded citation at the bottom separate from `response.citations`, which is empty offline.

## Run

```
bin/learn 22
GLASS_BOX_MODE=offline bin/demo 22
```

`bin/learn 22` prints this lesson and then runs the step. `bin/demo 22` runs the standalone demo in `demos/22-thinking-and-provider-tools`.

Docs: https://rubyllm.com/thinking/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
