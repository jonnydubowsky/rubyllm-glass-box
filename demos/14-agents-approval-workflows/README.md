# 14. An agent, a tool that needs approval, and a workflow

`SupportAgent` with `IssueRefund`, `requires_approval`, inside `RubyLLM.workflow`. The tour's `pending_approvals` and `agent.approve` are `pending_questions` and `question.approve` on this gem. The decline path is the default when stdin is not a terminal. The reply then says the refund was not issued. `GLASS_BOX_APPROVE=yes` runs the tool and the reply says it was issued.

## Run

```
ruby demos/14-agents-approval-workflows/run.rb
```

Or `bin/demo 14`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/tool-execution/

Guided lesson: `guided/lessons/14-agents-approval-workflows.md`
