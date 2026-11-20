# 10. Structured output with a Schematist schema

`with_schema` constrains the reply. The tour subclasses `Schematist::Schema`. ruby_llm 2.2.3 still accepts that class. There is no `RubyLLM::Schema` in this release.

The schema here is a brand card: company, composite, band. Before the ask, the step prints `SBPI.explain` for Night Bazaar. The composite 85.9 and the band Category Dominant are the weighted sum of the five inputs in the catalog. The offline stub returns that same JSON. `response.parsed` is the parsed object.

Look at the table of weights, then `response.parsed` next to the Ruby card. When you run live, the model fills the schema and the Ruby card is still the number to trust.

## Run

```
bin/learn run 10
ruby demos/10-structured-output/run.rb
```

Docs: https://rubyllm.com/structured-output/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
