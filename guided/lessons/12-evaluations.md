# 12. Evaluating an agent against a dataset

`RubyLLM::Evaluation` runs an agent against a dataset. If the evaluator stays on, the chat model grades each answer. This course sets `evaluator false` and checks each answer with a Minitest assertion, so the result is the same on every run and needs no network.

The guided dataset is `guided/evals/brand_score.yml`. Its `perform` method loads the company and returns `company.band`, and the assertion compares that string with `expected_output`. All five fictional companies must pass. If one fails, the assertion raises an error and the step does not save its checkpoint.

The tour's demo in `demos/12-evaluations` uses a different dataset. Its agent gives a wrong answer about sale items on purpose, so `passed?` is false and the process still exits 0. Read that demo's report for the failing line. Neither run uses a model to grade answers.

## Run

```
bin/learn run 12
ruby demos/12-evaluations/run.rb
```

Docs: https://rubyllm.com/evaluations/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
