# 10. Structured output with a Schematist schema

## The concept

`with_schema` constrains the shape of the reply. You describe the shape as a class, and `response.parsed` returns the reply as a Ruby hash with those keys. The tour subclasses `Schematist::Schema`, and ruby_llm 2.2.3 still accepts that class. This release has no `RubyLLM::Schema`.

## What this step does

The schema in this step describes a brand card with a company, a composite score and a band. Before the ask, the step prints `SBPI.explain` for Night Bazaar. Its composite of 85.9 and its band, Category Dominant, come from the weighted sum of the five inputs in the catalog.

The step then asks: "Return a score card for Night Bazaar. Its composite is 85.9 and its band is Category Dominant." The schema fixes the keys of the reply, and the prompt supplies the values. Offline, the stub returns the same values as JSON.

## What to look at

Read the table of weights and check the sum. Then compare `[response.parsed]` with `[ruby card]`. The two hashes should match. If they differ in live mode, the Ruby card holds the number to trust.

## Run

```
bin/learn 10
GLASS_BOX_MODE=offline bin/demo 10
```

`bin/learn 10` prints this lesson and then runs the step. `bin/demo 10` runs the standalone demo in `demos/10-structured-output`.

Docs: https://rubyllm.com/structured-output/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
