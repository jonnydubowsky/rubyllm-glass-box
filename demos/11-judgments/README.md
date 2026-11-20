# 11. Typed judgments with probabilities and choices

This demo defines `TicketTriage < RubyLLM::Judge` with a probability field and a choice field, as on the tour's card. A code comment names `clef-flash` on Ollama, and the demo never calls it. In live mode, the demo tries TypeSafe `jev-latest` first, then OpenAI `gpt-6-luna`, then Gemini `gemini-decision-1`. Otherwise, the demo builds a `Judgment` from a fixture in the same process, and the log says it didn't call the judge.

## Run

```
GLASS_BOX_MODE=offline bin/demo 11
```

You can also run `ruby demos/11-judgments/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/judgments/

Guided lesson: `guided/lessons/11-judgments.md`
