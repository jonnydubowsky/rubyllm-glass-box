# 10. Structured output with a Schematist schema

This demo defines `ProductSchema < Schematist::Schema` with a name, a price and an array of strings. `Schematist::Schema` is still the class this gem accepts, and the gem has no `RubyLLM::Schema`. The prompt attaches `demos/fixtures/product.txt`. Offline, `response.parsed` returns the mug hash from the tour.

## Run

```
GLASS_BOX_MODE=offline bin/demo 10
```

You can also run `ruby demos/10-structured-output/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends one chat request with the schema and the attached text file to your default chat model.

## What to look at

`[source]` is the product note as its author typed it. `[response.parsed]` is a Ruby hash with the keys that the schema declares. Check each value against the note. The name is Ruby Mug, the price is 18.0, and the features are ceramic, 12 oz and dishwasher safe.

Docs: https://rubyllm.com/structured-output/

Guided lesson: `guided/lessons/10-structured-output.md`
