# 13. Tracing a run with OpenTelemetry

`RubyLLM::OpenTelemetry.enable` subscribes the gem's instrumentation to OpenTelemetry. The same events are what a local tracer records here: chat, tool call, workflow, and workflow step, with a duration.

The step wraps one narration of Harbor and Thorn inside `RubyLLM.workflow` and a named step. The trace prints those names. The score table under the trace is Harbor and Thorn at 48.8, Niche Player, from the weighted sum.

Look at the waterfall. Names and times are the glass box. The paragraph the model returns is not a substitute for the span list.

## Run

```
bin/learn run 13
ruby demos/13-opentelemetry/run.rb
```

Docs: https://rubyllm.com/opentelemetry/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
