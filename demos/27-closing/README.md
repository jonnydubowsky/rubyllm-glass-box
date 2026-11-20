# 27. Use Ruby

This demo prints the install command `bundle add ruby_llm --version 2.2.3`, the RubyLLM site at https://rubyllm.com/ and the address of the tour video. The tour's last card has no code, so this script closes the set.

## Run

```
GLASS_BOX_MODE=offline bin/demo 27
```

You can also run `ruby demos/27-closing/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

This demo calls no provider in any mode.

## What to look at

The script prints the closing card's two sentences, the install command with the pinned version, and the addresses of the site and the tour video. The last line is the gem version that Bundler loaded.

Docs: https://rubyllm.com/

Guided lesson: `guided/lessons/27-closing.md`
