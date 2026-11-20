# 14. An agent, a tool that needs approval, and a workflow

An agent is a class with a model, instructions, and tools. A workflow names the steps around it. A tool with `requires_approval` pauses the run and shows the arguments.

The tour's tool refunds order 42, and the on-screen API is `agent.pending_approvals` and `agent.approve`. ruby_llm 2.2.3 uses `pending_questions` and `question.approve` or `question.decline`. `chat.approve(tool_call)` still exists. This step uses the question API.

The tool is `publish_score`. It does not invent a number. It loads Night Bazaar and returns composite 85.9 and Category Dominant. The step waits for the word yes. `bin/learn auto` sets `GLASS_BOX_APPROVE=yes`. A decline completes the turn with "not published" and does not save the checkpoint.

Look at the approval card before you answer, then at the tool result after you approve. That result is the published card.

## Run

```
bin/learn run 14
ruby demos/14-agents-approval-workflows/run.rb
```

Docs: https://rubyllm.com/tool-execution/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
