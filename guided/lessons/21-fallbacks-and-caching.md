# 21. Model fallbacks and prompt caching

`with_fallbacks` names the model to try next, and `with_caching(ttl:)` marks a cache boundary. The tour shows a cache hit. This course prints `response.tokens.cache_read` only when the provider reports one and never prints a hit on its own. A missing cache read is different from zero.

Offline, the stub raises `RubyLLM::OverloadedError` and then returns a sentence. The chat started on `claude-sonnet-5`, and the reply's `model_id` is `claude-haiku-4-5`. `chat.model.id` still shows the model you asked for. The sentence names Harbor and Thorn's band, which comes from the scorer.

In live mode, the step sends the request only when Anthropic is configured. It prints the caching settings in both modes.

## Run

```
bin/learn run 21
ruby demos/21-fallbacks-and-caching/run.rb
```

Docs: https://rubyllm.com/error-handling/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
