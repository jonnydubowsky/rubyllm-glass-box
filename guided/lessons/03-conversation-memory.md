# 03. The same chat remembers the last turn

A second `ask` on the same chat object continues the conversation, so you don't rebuild a message array.

The first turn summarizes The Last Lantern, and the second turn asks how it compares with Stall Seven. After the second ask, the program prints the role of every message. That list is the history the next request would carry. The episode counts, 48 and 120, come from the catalog.

The roles print in the order user, assistant, user, assistant. The second user message never repeats the first title, because the chat object still holds the first turn.

## Run

```
bin/learn run 3
ruby demos/03-conversation-memory/run.rb
```

Docs: https://rubyllm.com/chat/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
