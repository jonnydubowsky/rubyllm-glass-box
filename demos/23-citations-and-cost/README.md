# 23. Citations and cost tracking

This demo calls `with_citations` on an ask that attaches `demos/fixtures/notes.txt`, then prints `response.citations` and `chat.cost.total`. Offline, the citation list is empty, and the stubbed total is 0.0042, the figure on the tour's gauge. The demo leaves an empty citation list empty and prints the recorded card only as a labeled example.

## Run

```
GLASS_BOX_MODE=offline bin/demo 23
```

You can also run `ruby demos/23-citations-and-cost/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/citations/

Guided lesson: `guided/lessons/23-citations-and-cost.md`
