# 15. Nineteen providers, one Ruby API

`RubyLLM.chat(model:)` and `RubyLLM.chat(model:, provider:)` are the same call against different registries. The tour prints three constructor lines and counts 19 providers. This gem's registry lists 23 slugs, and the four that the tour's card lacks are meta, minimax, moonshot and zai. The step prints the current list from `RubyLLM::Provider.providers`.

The step asks three chats, on OpenAI, Anthropic and Gemini, for Copperframe's band. Each sentence includes Copperframe's composite of 30.75 and its band, Limited Structural Presence, which Ruby computed before the ask. In live mode, the step skips any provider that is not configured. Offline, the stub skips the key check, so all three lines print.

The demo also creates a Bedrock chat. In live mode, that constructor needs `BEDROCK_API_KEY`, `BEDROCK_SECRET_KEY` and `BEDROCK_REGION`. Offline, the stub lets it run without them.

## Run

```
bin/learn run 15
ruby demos/15-providers-one-api/run.rb
```

Docs: https://rubyllm.com/models/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
