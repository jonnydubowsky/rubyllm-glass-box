# 14. An agent, a tool that needs approval, and a workflow

## The concept

An agent is a class with a model, instructions and tools. A workflow names the steps around the agent, so a trace shows them by name. A tool marked `requires_approval` pauses the run before the tool executes. The pending call appears in `agent.pending_questions`, with the tool's name and arguments. `question.approve` or `question.decline` records the decision, and `agent.complete` continues the run.

The tour's tool refunds order 42, and the API on screen is `agent.pending_approvals` and `agent.approve`. ruby_llm 2.2.3 uses `pending_questions` with `question.approve` or `question.decline`. `chat.approve(tool_call)` still exists, and this step uses the question API.

## What this step does

The agent is `ScorePublisher`, and its one tool is `publish_score`. The step asks: "Publish the Night Bazaar score card." The model calls the tool, and the run pauses. The tool loads Night Bazaar from the catalog and returns the composite of 85.9 and the band Category Dominant, and it computes no new number.

The step waits for you to type yes, and `bin/learn auto` sets `GLASS_BOX_APPROVE=yes` for you. If you decline, the turn ends with "The card was not published." and the step does not save its checkpoint.

## What to look at

Read the `APPROVAL NEEDED` line before you answer. It shows the tool name and the arguments the model chose. After you approve, the tool result in the transcript is the card that gets published. Check its composite and band against step 10.

## Run

```
bin/learn 14
GLASS_BOX_MODE=offline bin/demo 14
```

`bin/learn 14` prints this lesson and then runs the step. `bin/demo 14` runs the standalone demo in `demos/14-agents-approval-workflows`.

Docs: https://rubyllm.com/tool-execution/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
