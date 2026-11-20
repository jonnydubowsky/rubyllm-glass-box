# 06. Attachments: a path, a URL, and mixed files

This demo uses four files in `demos/fixtures`, a PNG, a PDF, a text note and a short MP4 stub, and prints the MIME type that Marcel detects for each one. It then makes the tour's attachment calls. The first ask passes one path with `with:`. The demo prints the URL form and sends nothing for it. The last ask passes an array of mixed files. The MP4 file is a 20-byte stub that won't play, so the demo attaches it only offline.

## Run

```
GLASS_BOX_MODE=offline bin/demo 06
```

You can also run `ruby demos/06-attachments/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends two chat requests to your default chat model. The first attaches the PNG, and the second attaches the PNG, the PDF and the text note. Your model has to accept images and PDF files.

## What to look at

The first block lists the MIME type for each fixture file. Under each reply, every `attachment` line names a file that the chat attached to the user message, with the type the gem detected. One path produces one attachment line, and the array produces one line per file.

Docs: https://rubyllm.com/attachments/

Guided lesson: `guided/lessons/06-attachments.md`
