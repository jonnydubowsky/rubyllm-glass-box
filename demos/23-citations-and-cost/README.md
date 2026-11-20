# 23. Citations and cost tracking

`with_citations` on an ask that attaches `demos/fixtures/notes.txt`. Prints `response.citations` and `chat.cost.total`. Offline citations are empty and the stubbed total is 0.0042, the figure on the tour's gauge. An empty citation list is not filled in from the recorded card. The card is printed only as a labeled example.

## Run

```
ruby demos/23-citations-and-cost/run.rb
```

Or `bin/demo 23`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/citations/

Guided lesson: `guided/lessons/23-citations-and-cost.md`
