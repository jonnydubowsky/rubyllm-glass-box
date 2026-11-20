# 06. Attachments: a path, a URL, and mixed files

Prints Marcel types for a PNG, a PDF, a text note, and a short MP4 stub, all under `demos/fixtures`. Passes those paths to `ask` with `with:`. Prints the tour's URL form and does not fetch it. The MP4 is not a playable clip. It exists so a path and a video MIME type are real.

## Run

```
ruby demos/06-attachments/run.rb
```

Or `bin/demo 06`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/attachments/

Guided lesson: `guided/lessons/06-attachments.md`
