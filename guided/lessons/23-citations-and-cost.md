# 23. Citations and cost tracking

`with_citations` asks the provider to attach sources. `response.citations` is the list. `chat.cost.total` is the running total, and it stays nil when the provider did not price the call.

This step first prints Kite Alley's score table: composite 62.3, Emerging Power. That table does not come from the model. The ask then reads `demos/fixtures/notes.txt`. Offline, the reply is a stub, citations are empty, and the cost line shows the stubbed total. The demo uses 0.0042 so you can see the same shape as the tour's cost gauge.

Look at the cost line and the citations section as separate facts.

## Run

```
bin/learn run 23
ruby demos/23-citations-and-cost/run.rb
```

Docs: https://rubyllm.com/citations/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
