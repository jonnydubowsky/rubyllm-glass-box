# 12. Evaluating an agent against a dataset

`evaluator false`, so a Ruby assertion grades the cases and the chat model does not. The agent is wrong on sale items. That case fails, `passed?` is false, and the script still exits 0. The report is `tmp/evaluations/FaqEvaluation.json`. The tour leaves the evaluator on and asks a model whether the answer matches. This demo does not.

## Run

```
ruby demos/12-evaluations/run.rb
```

Or `bin/demo 12`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/evaluations/

Guided lesson: `guided/lessons/12-evaluations.md`
