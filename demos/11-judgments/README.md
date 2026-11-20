# 11. Typed judgments with probabilities and choices

`TicketTriage < RubyLLM::Judge` with a probability and a choice, matching the tour's fields. The comment shows `clef-flash` on Ollama and does not call it. Live order: TypeSafe `jev-latest`, then OpenAI `gpt-6-luna`, then Gemini `gemini-decision-1`. Otherwise a fixture `Judgment` is built in process and the log says the judge was not called.

## Run

```
ruby demos/11-judgments/run.rb
```

Or `bin/demo 11`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/judgments/

Guided lesson: `guided/lessons/11-judgments.md`
