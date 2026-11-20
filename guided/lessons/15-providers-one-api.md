# 15. Nineteen providers, one Ruby API

## The concept

`RubyLLM.chat(model:)` returns the same kind of chat object for every provider. The gem looks the model id up in its registry to find the provider. `provider:` names the provider yourself, which matters when several providers serve the same model. Every later call, such as `ask`, is the same for each provider.

The tour prints three constructor lines and counts 19 providers. This gem's registry lists 23 slugs, and the four that the tour's card lacks are meta, minimax, moonshot and zai.

## What this step does

The step prints the current provider list from `RubyLLM::Provider.providers`. It then sends one prompt to three chats, on OpenAI, Anthropic and Gemini: "Copperframe has a composite of 30.75 in the Limited Structural Presence band. Say so in one sentence." Ruby computed the composite and the band before the ask. In live mode, the step skips any provider that is not configured. Offline, the stub skips the key check, so all three lines print.

## What to look at

Count the slugs in the provider list. Then read the reply lines, one per provider, and check each against the prompt. `demos/15-providers-one-api` also creates a Bedrock chat. In live mode, that constructor needs `BEDROCK_API_KEY`, `BEDROCK_SECRET_KEY` and `BEDROCK_REGION`.

## Run

```
bin/learn 15
GLASS_BOX_MODE=offline bin/demo 15
```

`bin/learn 15` prints this lesson and then runs the step. `bin/demo 15` runs the standalone demo in `demos/15-providers-one-api`.

Docs: https://rubyllm.com/models/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
