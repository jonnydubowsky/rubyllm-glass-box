# 23. Citations and cost tracking

## The concept

`with_citations` asks the provider to attach sources to the reply, and `response.citations` holds the list. Each citation has a title and the text it cites. `chat.cost.total` keeps a running total for the chat, and it stays nil when the provider didn't price the call.

## What this step does

The step first prints Kite Alley's score table, with a composite of 62.3 in the Emerging Power band. Ruby code computes that table without the model. The step then attaches `demos/fixtures/notes.txt` and asks: "What does the note say?"

Offline, the reply comes from the stub, the citation list is empty, and the cost line shows the stubbed total of 0.0042. The tour's cost gauge shows the same figure.

## What to look at

Read the citations section and the cost line as two separate facts. An empty citation list means the provider attached no sources, and the step prints nothing in their place. In live mode, check each citation's text against the note file.

## Run

```
bin/learn 23
GLASS_BOX_MODE=offline bin/demo 23
```

`bin/learn 23` prints this lesson and then runs the step. `bin/demo 23` runs the standalone demo in `demos/23-citations-and-cost`.

Docs: https://rubyllm.com/citations/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
