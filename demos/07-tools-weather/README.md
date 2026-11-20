# 07. A Ruby tool the model can call

This demo defines a `Weather` tool with `execute(latitude:, longitude:)`, as the tour does. The tool reads its answer from a local hash and never calls a weather API. The scripted call uses the tour's coordinates for Berlin, 52.52 and 13.41. The transcript shows the tool call, the hash the tool returns and the model's reply.

## Run

```
GLASS_BOX_MODE=offline bin/demo 07
```

You can also run `ruby demos/07-tools-weather/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/tools/

Guided lesson: `guided/lessons/07-tools-weather.md`
