# 03. The same chat remembers the last turn

A second `ask` on the same chat object continues the conversation. You do not rebuild a message array.

The first turn summarizes The Last Lantern. The second turn asks for a comparison with Stall Seven. The program prints every message role after the second ask, which is the history the next request would carry. Episode counts come from the catalog: 48 and 120.

Look at four lines: user, assistant, user, assistant. The second user message does not repeat the first title. The chat object is holding it.

## Run

```
bin/learn run 3
ruby demos/03-conversation-memory/run.rb
```

Docs: https://rubyllm.com/chat/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
