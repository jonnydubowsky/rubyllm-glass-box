# 06. Attachments: a path, a URL, and mixed files

`chat.ask` takes `with:` as a path, a URL or a list of mixed files, and the tour shows each form. This step attaches `demos/fixtures/notes.txt` and prints the MIME type that Marcel reports for that path.

The URL form is valid, and nothing in this step fetches a URL. The offline reply gives the title and the episode count. The note file holds the same facts, and the log prints the file's path and size in bytes so you can see what the step handed to the chat.

Read the `attached` line, and then read the attachment list that the demo prints from `chat.messages`. The demo also attaches a PNG, a PDF and a short MP4 stub.

## Run

```
bin/learn run 6
ruby demos/06-attachments/run.rb
```

Docs: https://rubyllm.com/attachments/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
