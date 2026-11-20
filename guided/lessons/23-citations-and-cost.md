# 23. Citations and cost tracking

`with_citations` asks the provider to attach sources, and `response.citations` holds the list. `chat.cost.total` keeps a running total, and it stays nil when the provider didn't price the call.

This step first prints Kite Alley's score table, with a composite of 62.3 in the Emerging Power band. Ruby code computes that table without the model. The ask then reads `demos/fixtures/notes.txt`. Offline, the reply comes from the stub, the citation list is empty, and the cost line shows the stubbed total. The demo uses 0.0042 so the cost line matches the shape of the tour's cost gauge.

Read the cost line and the citations section as two separate facts.

## Run

```
bin/learn run 23
ruby demos/23-citations-and-cost/run.rb
```

Docs: https://rubyllm.com/citations/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
