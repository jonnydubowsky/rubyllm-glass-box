# 14. An agent, a tool that needs approval, and a workflow

This demo builds a `SupportAgent` with an `IssueRefund` tool marked `requires_approval`, inside `RubyLLM.workflow`. The tour calls `pending_approvals` and `agent.approve`, and this gem names them `pending_questions` and `question.approve`. When stdin is not a terminal, the demo declines by default, and the reply says the refund was not issued. With `GLASS_BOX_APPROVE=yes`, the tool runs and the reply says the refund was issued. The tour's agent names `claude-sonnet-5`. In live mode without an Anthropic key, the agent uses your default chat model.

## Run

```
GLASS_BOX_MODE=offline bin/demo 14
```

You can also run `ruby demos/14-agents-approval-workflows/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends chat requests to Anthropic, or to your default chat model when no Anthropic key is set. The refund tool returns a hash and moves no money.

## What to look at

The `APPROVAL NEEDED` block names the agent, the tool and the arguments. In the transcript of a declined run, the tool message holds an error and the reply says the refund was not issued. Run the demo again with `GLASS_BOX_APPROVE=yes`. The tool result then reads `{refunded: true, order_id: 42}`.

Docs: https://rubyllm.com/tool-execution/

Guided lesson: `guided/lessons/14-agents-approval-workflows.md`
