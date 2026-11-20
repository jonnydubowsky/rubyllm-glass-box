# 20. Faster by default in RubyLLM 2.1

Prints the four measurements from the RubyLLM 2.1 card and the installed version. Does not benchmark. The numbers are the tour's comparison with 2.0, not a measurement of this machine.

## Run

```
ruby demos/20-faster-by-default/run.rb
```

Or `bin/demo 20`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/whats-new-in-2-1/

Guided lesson: `guided/lessons/20-faster-by-default.md`
