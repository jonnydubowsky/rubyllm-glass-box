# 14. An agent, a tool that needs approval, and a workflow

This demo builds a `SupportAgent` with an `IssueRefund` tool marked `requires_approval`, inside `RubyLLM.workflow`. The tour calls `pending_approvals` and `agent.approve`, and this gem names them `pending_questions` and `question.approve`. When stdin is not a terminal, the demo declines by default, and the reply says the refund was not issued. With `GLASS_BOX_APPROVE=yes`, the tool runs and the reply says the refund was issued.

## Run

```
GLASS_BOX_MODE=offline bin/demo 14
```

You can also run `ruby demos/14-agents-approval-workflows/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/tool-execution/

Guided lesson: `guided/lessons/14-agents-approval-workflows.md`
