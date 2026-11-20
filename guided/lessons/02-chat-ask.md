# 02. chat.ask starts a conversation

`RubyLLM.chat` opens a conversation. `chat.ask` sends one prompt and returns the reply.

The exercise asks for one sentence on The Last Lantern. The prompt includes the blurb from `guided/data/catalog.yml`. The episode count in the offline reply is the integer stored on that title, 48. The model is narrating a row the program already loaded.

Look at the prompt log and the reply log next to each other, then the cost line. The same pair is what the tour puts on one screen.

## Run

```
bin/learn run 2
ruby demos/02-chat-ask/run.rb
```

Docs: https://rubyllm.com/chat/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
