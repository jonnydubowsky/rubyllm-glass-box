# 10. Structured output with a Schematist schema

`with_schema` constrains the shape of the reply. The tour subclasses `Schematist::Schema`, and ruby_llm 2.2.3 still accepts that class. This release has no `RubyLLM::Schema`.

The schema in this step describes a brand card with a company, a composite score and a band. Before the ask, the step prints `SBPI.explain` for Night Bazaar. Its composite of 85.9 and its band, Category Dominant, come from the weighted sum of the five inputs in the catalog. The offline stub returns the same values as JSON, and `response.parsed` holds the parsed object.

Read the table of weights, and then compare `response.parsed` with the card that Ruby printed. In live mode the model fills in the schema, and the Ruby card still holds the number to trust.

## Run

```
bin/learn run 10
ruby demos/10-structured-output/run.rb
```

Docs: https://rubyllm.com/structured-output/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
