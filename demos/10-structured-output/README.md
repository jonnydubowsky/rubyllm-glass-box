# 10. Structured output with a Schematist schema

`ProductSchema < Schematist::Schema` with name, price, and a string array. That is still the class this gem accepts. The prompt attaches `demos/fixtures/product.txt`. Offline, `response.parsed` is the mug hash from the tour. There is no `RubyLLM::Schema`.

## Run

```
ruby demos/10-structured-output/run.rb
```

Or `bin/demo 10`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/structured-output/

Guided lesson: `guided/lessons/10-structured-output.md`
