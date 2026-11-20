# 11. Typed judgments with probabilities and choices

## The concept

A `RubyLLM::Judge` asks a model typed questions about a text. A `probability` field returns a number from 0 to 1. A `choice` field returns one of the labels you declared, with a confidence value. You read them as `judgment.urgent.probability` and `judgment.department.choice`.

The default judgment model is TypeSafe `jev-latest`. The tour also shows `model "clef-flash", provider: :ollama`. That model id stays out of the bundled registry until Ollama is running and the registry is refreshed, so this course never calls it.

## What this step does

The step's judge has two fields, `urgent` ("Is the ticket urgent?") and `department` ("Which desk should take it?"). The step judges one fictional support ticket: "Night Bazaar playback failed on episode 12 of Stall Seven."

With a TypeSafe key, the step calls `jev-latest`. Without one, the step uses OpenAI `gpt-6-luna` if an OpenAI key is set, and then Gemini `gemini-decision-1` if a Gemini key is set. With none of those keys, the step builds a `RubyLLM::Judgment` in the same process, with urgent at 0.97, department technical and confidence 0.91. The log says the step did not call the judge.

## What to look at

Read `[fixture]` or `[provider]` first to learn whether a model made the judgment. Then read the probability and the choice. The judgment routes a ticket and scores no brand. The last line prints Lantern Reel's composite of 68.5 and its band, Emerging Power, from the local weighted sum.

## Run

```
bin/learn 11
GLASS_BOX_MODE=offline bin/demo 11
```

`bin/learn 11` prints this lesson and then runs the step. `bin/demo 11` runs the standalone demo in `demos/11-judgments`.

Docs: https://rubyllm.com/judgments/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
