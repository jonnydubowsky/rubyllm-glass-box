# 06. Attachments: a path, a URL, and mixed files

`chat.ask` takes `with:` as a path, a URL, or a list of mixed files. The tour shows each form. This step attaches `demos/fixtures/notes.txt` and prints the MIME type Marcel reports for that path.

The URL form is valid. Nothing in this step fetches a URL. The offline reply states the title and the episode count. Those facts are also in the note file, which the log prints by path and byte size so you can see what was handed to the chat.

Look at the `attached` line, then the attachment list the demo prints from `chat.messages`. The demo also passes a PNG, a PDF, and a short MP4 stub.

## Run

```
bin/learn run 6
ruby demos/06-attachments/run.rb
```

Docs: https://rubyllm.com/attachments/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
