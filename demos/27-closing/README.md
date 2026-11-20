# 27. Use Ruby

Prints `gem install ruby_llm`, the pinned version, https://rubyllm.com/, and the tour file. The tour's last card has no demo directory. This script is the closing note for the set.

## Run

```
ruby demos/27-closing/run.rb
```

Or `bin/demo 27`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/

Guided lesson: `guided/lessons/27-closing.md`
