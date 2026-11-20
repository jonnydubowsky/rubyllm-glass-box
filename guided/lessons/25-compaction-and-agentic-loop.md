# 25. Compaction and the agentic loop

## The concept

An agentic loop repeats model turns and tool calls until the model has its answer. `chat.ask` runs the whole loop for you. `ask_later` queues the user message, and each `chat.step` call then runs one part of the loop, which is a model turn or a tool call. The loop is over when `complete?` returns true, and the chat waits for a person when `waiting?` returns true.

`with_compaction(at:)` sets the input-token count at which the provider shrinks a long history. Anthropic and OpenAI replace the older turns with a summary.

## What this step does

The step sets a compaction threshold of 50_000 tokens, queues this question and calls `chat.step` until the chat is complete: "How many episodes does Room 4B have?" In the scripted run, the model calls `catalog_lookup`, and the tool returns Copperframe, 12 episodes and the logline. The transcript is short, so compaction never rewrites it, and `chat.compaction` still shows the setting.

## What to look at

Read the numbered `step` lines. Each one shows the state of the loop, the role of the message that the step produced and the start of its content. The episode count comes from the `[tool result]` hash, and the last assistant message repeats it.

## Run

```
bin/learn 25
GLASS_BOX_MODE=offline bin/demo 25
```

`bin/learn 25` prints this lesson and then runs the step. `bin/demo 25` runs the standalone demo in `demos/25-compaction-and-agentic-loop`.

Docs: https://rubyllm.com/agentic-workflows/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
