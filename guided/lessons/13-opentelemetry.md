# 13. Tracing a run with OpenTelemetry

`RubyLLM::OpenTelemetry.enable` sends the gem's instrumentation events to OpenTelemetry. A local tracer in this step records the same events for the chat, the tool call, the workflow and the workflow step, each with a duration.

The step runs one description of Harbor and Thorn inside `RubyLLM.workflow` and a named step, and the trace prints those names. Under the trace, a score table shows Harbor and Thorn at 48.8, in the Niche Player band, from the weighted sum.

Read the waterfall chart. The span names and times record each call the program made, so check them before you read the model's paragraph.

## Run

```
bin/learn run 13
ruby demos/13-opentelemetry/run.rb
```

Docs: https://rubyllm.com/opentelemetry/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
