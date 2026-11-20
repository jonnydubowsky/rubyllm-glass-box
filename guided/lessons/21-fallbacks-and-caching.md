# 21. Model fallbacks and prompt caching

## The concept

`with_fallbacks` names the model to try next when the first model fails with an error such as an overload. The reply's `model_id` tells you which model answered, and `chat.model.id` still shows the model you asked for.

`with_caching(ttl:)` marks a cache boundary, so a provider can reuse the unchanged start of a long prompt. When the provider reads from its cache, `response.tokens.cache_read` holds the token count.

## What this step does

The step opens a chat on `claude-sonnet-5` with `claude-haiku-4-5` as the fallback and a caching `ttl` of one hour. It asks: "Harbor and Thorn has a composite of 48.8 in the Niche Player band. Say so in one sentence."

Offline, the stub raises `RubyLLM::OverloadedError` on the first request and then returns a sentence, so the fallback model answers. In live mode, the step sends the request only when Anthropic is configured, and the fallback runs only if the first model fails.

## What to look at

Read `[caching]` for the settings and `[fallback]` for the switch to the second model. Under `[response.model_id]`, the offline run prints `claude-haiku-4-5`. The tour shows a cache hit. This step prints a `cache_read` number only when the provider reports one, and a missing cache read is different from zero.

## Run

```
bin/learn 21
GLASS_BOX_MODE=offline bin/demo 21
```

`bin/learn 21` prints this lesson and then runs the step. `bin/demo 21` runs the standalone demo in `demos/21-fallbacks-and-caching`.

Docs: https://rubyllm.com/error-handling/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
