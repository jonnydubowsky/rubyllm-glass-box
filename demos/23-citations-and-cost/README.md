# 23. Citations and cost tracking

This demo calls `with_citations` on an ask that attaches `demos/fixtures/notes.txt`, then prints `response.citations` and `chat.cost.total`. Offline, the citation list is empty, and the stubbed total is 0.0042, the figure on the tour's gauge. The demo leaves an empty citation list empty and prints the recorded card only as a labeled example.

## Run

```
GLASS_BOX_MODE=offline bin/demo 23
```

You can also run `ruby demos/23-citations-and-cost/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends one chat request with the attached note and citations turned on to your default chat model.

## What to look at

`[reply]` is the model's answer about the note. `[citations]` lists what the provider attached, and offline the list is empty. The recorded card under it carries a label that says it came from outside this response. The last line is `chat.cost.total`.

Docs: https://rubyllm.com/citations/

Guided lesson: `guided/lessons/23-citations-and-cost.md`
