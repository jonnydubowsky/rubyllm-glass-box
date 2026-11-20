# 12. Evaluating an agent against a dataset

`RubyLLM::Evaluation` runs a dataset. If you leave the evaluator on, the chat model grades each answer. This course sets `evaluator false` and checks the answer with a Minitest assertion. That keeps the result deterministic and offline.

The guided dataset is `guided/evals/brand_score.yml`. `perform` loads the company and returns `company.band`. The assertion compares that string to `expected_output`. All five fictional companies must pass. A failure raises, and the checkpoint is not saved.

The tour demo in `demos/12-evaluations` is a different dataset. Its agent is wrong on sale items on purpose, so `passed?` is false and the process still exits 0. Read the report. The failing line is the point of that demo. Neither run uses a model as the grader.

## Run

```
bin/learn run 12
ruby demos/12-evaluations/run.rb
```

Docs: https://rubyllm.com/evaluations/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
