# 09. Tool search and an MCP App approval

## The concept

A chat with many tools sends every tool definition in every request. Deferred tools stay out of the first request. When the model needs one, it calls `tool_search` to load it by name. OpenAI's Responses API and Anthropic run that search as a provider tool. Gemini's protocol has no such tool, so ruby_llm 2.2.3 adds a local `tool_search` tool.

A tool marked `requires_approval` pauses the chat before it runs. The pending call appears in `chat.pending_questions`. You call `question.approve` or `question.decline`, and then `chat.complete` continues the turn. The tour names this API `pending_approvals` and `agent.approve`.

## What this step does

The step defers two tools on `gemini-3.7-flash`, so the local `tool_search` runs, and asks: "Add a public note on Paper Kites." In the scripted run, the model calls `tool_search` with `select:catalog_note`, and then calls `catalog_note`, which `requires_approval`. The step prints the pending call and waits for your answer. `GLASS_BOX_APPROVE=yes` approves the call, and a run with no terminal and no such variable declines it.

In live mode without a Gemini key, the step uses your default chat model. On OpenAI or Anthropic, the provider runs the search, and no local `tool_search` call appears. The tour's card follows its search with an MCP App panel, and this course never opens that panel.

## What to look at

Read `[deferred tools]`, and then the `tool_search` call and its result, which lists the tool it loaded. At `APPROVAL NEEDED`, read the title and the note before you answer. The transcript shows the tool result in both cases. When you decline, that result holds an error string.

## Run

```
bin/learn 9
GLASS_BOX_MODE=offline bin/demo 9
```

`bin/learn 9` prints this lesson and then runs the step. `bin/demo 9` runs the standalone demo in `demos/09-tool-search`.

Docs: https://rubyllm.com/tool-search/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
