# 02. chat.ask starts a conversation

## The concept

`RubyLLM.chat` opens a conversation. `chat.ask` sends one prompt and returns the reply. The reply's text is `response.content`, and `chat.cost.total` holds what the conversation has cost so far.

## What this step does

The step asks for one sentence about The Last Lantern. The prompt starts with "In one sentence, summarize this fictional series:" and then includes the title's blurb from `guided/data/catalog.yml`. The blurb says the series has forty-eight episodes, so the prompt holds the fact that the reply should repeat. Offline, the scripted reply gives the episode count as 48, the integer the catalog stores for that title.

## What to look at

Read `[prompt]` next to `[reply]`, and check the episode count in the reply against the blurb in the prompt. Then read the cost line. The tour shows the same kind of prompt and reply on a single screen.

## Run

```
bin/learn 2
GLASS_BOX_MODE=offline bin/demo 2
```

`bin/learn 2` prints this lesson and then runs the step. `bin/demo 2` runs the standalone demo in `demos/02-chat-ask`.

Docs: https://rubyllm.com/chat/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
