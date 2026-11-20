# 02. chat.ask starts a conversation

`RubyLLM.chat` opens a conversation, and `chat.ask` sends one prompt and returns the reply.

In this step, the learner asks for one sentence about The Last Lantern. The prompt includes the title's blurb from `guided/data/catalog.yml`. In the offline reply, the episode count is 48, the integer the catalog stores for that title. The program loaded that row before the ask, and the model's sentence only describes it.

Read the prompt log next to the reply log, and then read the cost line. The tour shows the same prompt and reply on a single screen.

## Run

```
bin/learn run 2
ruby demos/02-chat-ask/run.rb
```

Docs: https://rubyllm.com/chat/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
