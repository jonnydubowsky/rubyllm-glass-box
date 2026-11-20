# 13. Tracing a run with OpenTelemetry

Calls `RubyLLM::OpenTelemetry.enable`, which needs the `opentelemetry-api` gem. A local subscriber records the same instrumentation events and prints a waterfall for a workflow step that calls `lookup_order`. Durations are from this process.

## Run

```
ruby demos/13-opentelemetry/run.rb
```

Or `bin/demo 13`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/opentelemetry/

Guided lesson: `guided/lessons/13-opentelemetry.md`
