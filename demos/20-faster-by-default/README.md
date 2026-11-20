# 20. Faster by default in RubyLLM 2.1

This demo prints the four measurements on the RubyLLM 2.1 card and the installed gem version. It runs no benchmark. The numbers are the tour's comparison of 2.1 with 2.0, and the demo measures nothing on your machine.

## Run

```
GLASS_BOX_MODE=offline bin/demo 20
```

You can also run `ruby demos/20-faster-by-default/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

This demo calls no provider in any mode.

## What to look at

Read the four rows, each with a measurement and a comparison with RubyLLM 2.0. The line under the card names the installed gem version. The demo measures nothing on your machine, and the last line says so.

Docs: https://rubyllm.com/whats-new-in-2-1/

Guided lesson: `guided/lessons/20-faster-by-default.md`
