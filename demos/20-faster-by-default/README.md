# 20. Faster by default in RubyLLM 2.1

This demo prints the four measurements on the RubyLLM 2.1 card and the installed gem version. It runs no benchmark. The numbers are the tour's comparison of 2.1 with 2.0, and the demo measures nothing on your machine.

## Run

```
GLASS_BOX_MODE=offline bin/demo 20
```

You can also run `ruby demos/20-faster-by-default/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/whats-new-in-2-1/

Guided lesson: `guided/lessons/20-faster-by-default.md`
