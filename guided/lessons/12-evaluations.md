# 12. Evaluating an agent against a dataset

## The concept

`RubyLLM::Evaluation` runs your code against a dataset of cases. Each case has an input and an expected output, and the `perform` method produces an answer for one input. If the evaluator stays on, the chat model grades each answer. With `evaluator false`, the `assertions` method grades each answer with Minitest assertions, so the result is the same on every run and needs no network.

## What this step does

The dataset is `guided/evals/brand_score.yml`, with one case for each of the five fictional companies. `perform` loads the company and returns `company.band`, and the assertion compares that string with `expected_output`. No prompt goes to a model.

The step saves the report as `tmp/evaluations/BrandScoreEvaluation.json`. If a case fails, the step raises an error and does not save its checkpoint.

## What to look at

The report prints one line per case and then a count of passed and failed cases. All five should pass. `demos/12-evaluations` uses the tour's three case names, and its sale-item case fails on purpose. Run `bin/demo 12` to read a failing line.

## Run

```
bin/learn 12
GLASS_BOX_MODE=offline bin/demo 12
```

`bin/learn 12` prints this lesson and then runs the step. `bin/demo 12` runs the standalone demo in `demos/12-evaluations`.

Docs: https://rubyllm.com/evaluations/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
