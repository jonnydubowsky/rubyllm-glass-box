# 13. Tracing a run with OpenTelemetry

This demo calls `RubyLLM::OpenTelemetry.enable`, which needs the `opentelemetry-api` gem. A local subscriber records the same instrumentation events and prints a waterfall chart for a workflow step that calls `lookup_order`. The durations come from the process that runs the demo.

## Run

```
GLASS_BOX_MODE=offline bin/demo 13
```

You can also run `ruby demos/13-opentelemetry/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/opentelemetry/

Guided lesson: `guided/lessons/13-opentelemetry.md`
