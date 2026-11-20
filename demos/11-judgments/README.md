# 11. Typed judgments with probabilities and choices

This demo defines `TicketTriage < RubyLLM::Judge` with a probability field and a choice field, as on the tour's card. A code comment names `clef-flash` on Ollama, and the demo never calls it. In live mode, the demo tries TypeSafe `jev-latest` first, then OpenAI `gpt-6-luna`, then Gemini `gemini-decision-1`. Otherwise, the demo builds a `Judgment` from a fixture in the same process, and the log says it didn't call the judge.

## Run

```
GLASS_BOX_MODE=offline bin/demo 11
```

You can also run `ruby demos/11-judgments/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends one judgment request. The demo uses TypeSafe when `TYPESAFE_API_KEY` is set, then OpenAI, then Gemini. With none of those keys, a live run still uses the fixture.

## What to look at

Read `[fixture]` or `[provider]` first to learn whether a model made the judgment. Then read the probability and the choice. The `model` line names the judge, and offline it reads `offline-fixture`. The cost line prints nil when the provider reported no price.

Docs: https://rubyllm.com/judgments/

Guided lesson: `guided/lessons/11-judgments.md`
