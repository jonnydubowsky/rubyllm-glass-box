# 27. Use Ruby

This demo prints the install command `bundle add ruby_llm --version 2.2.3`, the RubyLLM site at https://rubyllm.com/ and the address of the tour video. The tour's last card has no code, so this script closes the set.

## Run

```
GLASS_BOX_MODE=offline bin/demo 27
```

You can also run `ruby demos/27-closing/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/

Guided lesson: `guided/lessons/27-closing.md`
