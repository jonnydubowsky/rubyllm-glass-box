# 10. Structured output with a Schematist schema

This demo defines `ProductSchema < Schematist::Schema` with a name, a price and an array of strings. `Schematist::Schema` is still the class this gem accepts, and the gem has no `RubyLLM::Schema`. The prompt attaches `demos/fixtures/product.txt`. Offline, `response.parsed` returns the mug hash from the tour.

## Run

```
GLASS_BOX_MODE=offline bin/demo 10
```

You can also run `ruby demos/10-structured-output/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/structured-output/

Guided lesson: `guided/lessons/10-structured-output.md`
