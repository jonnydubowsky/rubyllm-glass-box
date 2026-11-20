# 06. Attachments: a path, a URL, and mixed files

## The concept

`chat.ask` takes files through `with:`. The value can be a local path, a URL or an array that mixes file types, and the tour shows each form. The gem detects each file's MIME type with the Marcel library and sends the file in the form the provider expects.

## What this step does

The step attaches `demos/fixtures/notes.txt` and asks: "List only the title and the episode count you can read in this note." The note names The Last Lantern and 48 episodes. Before the ask, the step prints the file's path, the MIME type that Marcel reports for it and its size in bytes. The URL form is valid, and nothing in this step fetches a URL.

## What to look at

Read the `[attached]` line to see what the step handed to the chat. Then check the title and the episode count in the reply against the note file. `demos/06-attachments` also attaches a PNG, a PDF and a short MP4 stub.

## Run

```
bin/learn 6
GLASS_BOX_MODE=offline bin/demo 6
```

`bin/learn 6` prints this lesson and then runs the step. `bin/demo 6` runs the standalone demo in `demos/06-attachments`.

Docs: https://rubyllm.com/attachments/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
