# 13. Tracing a run with OpenTelemetry

## The concept

RubyLLM emits an instrumentation event for each chat request, tool call, workflow and workflow step. `RubyLLM::OpenTelemetry.enable` turns those events into OpenTelemetry spans, which a tracing backend can draw as a waterfall. `RubyLLM.workflow` and `workflow.step` give the spans the names you choose.

## What this step does

The step calls `RubyLLM::OpenTelemetry.enable` and also subscribes a local recorder to the same events, so the trace prints in the terminal with no tracing backend. Inside a workflow named "Score brand" and a step named "Compute", the step asks: "Harbor and Thorn has a composite of 48.8 in the Niche Player band. Say so in one sentence." Under the trace, the step prints the score table for Harbor and Thorn.

## What to look at

Read the `[trace]` block. Each row is one event with its duration, and the indentation shows which event ran inside which. The rows record each call the program made, so check them before you read the model's sentence. In the score table, check that the weighted sum is 48.8.

## Run

```
bin/learn 13
GLASS_BOX_MODE=offline bin/demo 13
```

`bin/learn 13` prints this lesson and then runs the step. `bin/demo 13` runs the standalone demo in `demos/13-opentelemetry`.

Docs: https://rubyllm.com/opentelemetry/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
