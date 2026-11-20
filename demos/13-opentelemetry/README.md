# 13. Tracing a run with OpenTelemetry

This demo calls `RubyLLM::OpenTelemetry.enable`, which needs the `opentelemetry-api` gem. A local subscriber records the same instrumentation events and prints a waterfall chart for a workflow step that calls `lookup_order`. The durations come from the process that runs the demo.

## Run

```
GLASS_BOX_MODE=offline bin/demo 13
```

You can also run `ruby demos/13-opentelemetry/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends chat requests to your default chat model until the model has answered. The `lookup_order` tool returns a fixed hash and calls no order service.

## What to look at

The `[trace]` block is the waterfall. The workflow is the outer row, and the step sits inside it. Inside the step, the two chat requests have the `lookup_order` tool call between them. The demo measures each duration in its own process, so the offline numbers are close to zero.

Docs: https://rubyllm.com/opentelemetry/

Guided lesson: `guided/lessons/13-opentelemetry.md`
