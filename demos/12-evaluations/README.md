# 12. Evaluating an agent against a dataset

This demo sets `evaluator false`, so a Ruby assertion grades each case and the chat model grades none. The agent gives the wrong answer about sale items. That case fails and `passed?` returns false, but the script still exits 0. The demo writes its report to `tmp/evaluations/FaqEvaluation.json`. The tour leaves the evaluator on and asks a model whether each answer matches, and this demo turns that off.

## Run

```
GLASS_BOX_MODE=offline bin/demo 12
```

You can also run `ruby demos/12-evaluations/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/evaluations/

Guided lesson: `guided/lessons/12-evaluations.md`
