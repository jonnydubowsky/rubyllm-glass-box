# 07. A Ruby tool the model can call

A tool is a Ruby class that the model can call. The tour's example is a weather tool with `execute(latitude:, longitude:)`. When you don't declare parameters yourself, this gem uses those keyword names as the parameter schema. The demo keeps that shape and takes its numbers from a local hash instead of a weather service.

The guided tool is `CatalogLookup`. In the scripted call, the model asks about Salt Wedding. The tool reads the catalog and returns the company Harbor and Thorn, the platform Harbor, 24 episodes and the logline. The assistant's next sentence restates that hash.

Read `[tool call]`, `[tool result]` and then the transcript. The episode count to trust is in the tool result, and the sentence after it repeats the number.

## Run

```
bin/learn run 7
ruby demos/07-tools-weather/run.rb
```

Docs: https://rubyllm.com/tools/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
