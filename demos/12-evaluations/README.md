# 12. Evaluating an agent against a dataset

This demo defines `SupportEvaluation` with the tour's three case names. The tour's `perform` asks a `SupportAgent`, and the tour leaves the evaluator on, so a model grades each answer. This demo answers from a lookup table and sets `evaluator false`, so a Ruby assertion grades each case. The lookup table gives the wrong answer about sale items on purpose. That case fails and `passed?` returns false, and the script still exits 0. The demo writes its report to `tmp/evaluations/SupportEvaluation.json`.

## Run

```
GLASS_BOX_MODE=offline bin/demo 12
```

You can also run `ruby demos/12-evaluations/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

This demo calls no provider in any mode.

## What to look at

The report lists the three cases. `sale_item` fails, and the diff under it shows the expected answer and the actual one. The count line reads 2 passed and 1 failed. `passed?` is false, and the script still exits 0 so that `bin/demo all` can continue.

Docs: https://rubyllm.com/evaluations/

Guided lesson: `guided/lessons/12-evaluations.md`
