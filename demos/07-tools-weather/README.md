# 07. A Ruby tool the model can call

This demo defines a `Weather` tool with `execute(latitude:, longitude:)`, as the tour does. The tool reads its answer from a local hash and never calls a weather API. The scripted call uses the tour's coordinates for Berlin, 52.52 and 13.41. The transcript shows the tool call, the hash the tool returns and the model's reply.

## Run

```
GLASS_BOX_MODE=offline bin/demo 07
```

You can also run `ruby demos/07-tools-weather/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends chat requests to your default chat model until the model has answered. The offline run makes two, one that returns the tool call and one that returns the reply. A live model decides for itself whether to call the tool. The tool never calls a weather API.

## What to look at

`[tool call]` shows the arguments the model chose, 52.52 and 13.41. `[tool result]` is the hash that `Weather#execute` returned. In the transcript, the tool's message sits between the two assistant messages, and the final sentence takes its 18°C from that hash.

Docs: https://rubyllm.com/tools/

Guided lesson: `guided/lessons/07-tools-weather.md`
