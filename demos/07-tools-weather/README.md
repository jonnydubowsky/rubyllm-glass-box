# 07. A Ruby tool the model can call

A `Weather` tool with `execute(latitude:, longitude:)`, matching the tour. The body calls a local hash, not a weather API. The stubbed call uses Berlin's coordinates from the tour, 52.52 and 13.41. The transcript shows the tool call, the hash, and the sentence.

## Run

```
ruby demos/07-tools-weather/run.rb
```

Or `bin/demo 07`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/tools/

Guided lesson: `guided/lessons/07-tools-weather.md`
