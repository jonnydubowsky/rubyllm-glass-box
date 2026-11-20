# 14. An agent, a tool that needs approval, and a workflow

An agent is a class with a model, instructions and tools, and a workflow names the steps around the agent. A tool marked `requires_approval` pauses the run and shows its arguments.

The tour's tool refunds order 42, and the API on screen is `agent.pending_approvals` and `agent.approve`. ruby_llm 2.2.3 uses `pending_questions` with `question.approve` or `question.decline`. `chat.approve(tool_call)` still exists, and this step uses the question API.

The tool in this step is `publish_score`. It loads Night Bazaar from the catalog and returns the composite of 85.9 and the band Category Dominant, and it computes no new number. The step waits for you to type yes, and `bin/learn auto` sets `GLASS_BOX_APPROVE=yes` for you. If you decline, the turn ends with "not published" and the step does not save its checkpoint.

Read the approval card before you answer. After you approve, the tool result is the card that gets published.

## Run

```
bin/learn run 14
ruby demos/14-agents-approval-workflows/run.rb
```

Docs: https://rubyllm.com/tool-execution/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
