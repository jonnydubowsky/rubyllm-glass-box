# 07. A Ruby tool the model can call

A tool is a Ruby class the model can call. The tour's example is weather, with `execute(latitude:, longitude:)`. This gem treats those keyword names as the parameter schema when you do not declare parameters yourself. The demo keeps that shape and fills the numbers from a local hash, not from a weather service.

The guided tool is `CatalogLookup`. The stubbed call asks for Salt Wedding. The tool reads the catalog and returns Harbor and Thorn, Harbor, 24 episodes, and the logline. The following assistant sentence is narration of that hash.

Look at `[tool call]`, `[tool result]`, and the transcript. The result hash is the glass box. The sentence after it should not be where you read the number.

## Run

```
bin/learn run 7
ruby demos/07-tools-weather/run.rb
```

Docs: https://rubyllm.com/tools/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
