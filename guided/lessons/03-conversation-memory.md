# 03. The same chat remembers the last turn

## The concept

A chat object keeps every message of the conversation. A second `ask` on the same chat sends the earlier turns along with the new prompt, so you don't rebuild a message array.

## What this step does

The step calls `ask` twice on one chat. The first prompt starts with "In one sentence, summarize this fictional series:" and includes the blurb for The Last Lantern. The second prompt starts with "Compare it with this one:" and includes the blurb for Stall Seven. The word "it" in the second prompt refers to The Last Lantern, and the model can resolve that word only from the first turn.

After the second ask, the step prints every message on the chat with its role. The episode counts in the offline replies, 48 and 120, come from the catalog.

## What to look at

The roles print in the order user, assistant, user, assistant. That list is the history the next request would carry. The second user message never names The Last Lantern, because the chat object still holds the first turn. The cost line shows the total for both asks.

## Run

```
bin/learn 3
GLASS_BOX_MODE=offline bin/demo 3
```

`bin/learn 3` prints this lesson and then runs the step. `bin/demo 3` runs the standalone demo in `demos/03-conversation-memory`.

Docs: https://rubyllm.com/chat/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
