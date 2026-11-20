# 15. Nineteen providers, one Ruby API

`RubyLLM.chat(model:)` and `RubyLLM.chat(model:, provider:)` are the same call against different registries. The tour prints three constructor lines and says 19 providers. This gem's registry lists 23 slugs. The extra slugs relative to that card are meta, minimax, moonshot, and zai. The step prints the live list from `RubyLLM::Provider.providers`.

Three chats, OpenAI, Anthropic, and Gemini, are asked for Copperframe's band. The sentence includes the composite 30.75, Limited Structural Presence, computed before the ask. A provider that is not configured is skipped when you are live. Offline, the stub skips the key check, so all three lines print.

The demo also constructs a Bedrock chat. That constructor needs `BEDROCK_API_KEY`, `BEDROCK_SECRET_KEY`, and `BEDROCK_REGION` when you are live. Offline, the stub allows it.

## Run

```
bin/learn run 15
ruby demos/15-providers-one-api/run.rb
```

Docs: https://rubyllm.com/models/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
