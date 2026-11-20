# 06. Attachments: a path, a URL, and mixed files

This demo uses four files in `demos/fixtures`. They are a PNG, a PDF, a text note and a short MP4 stub, and the demo prints the MIME type that Marcel detects for each one. It then passes the file paths to `ask` with `with:`. It also prints the URL form from the tour and leaves that URL unfetched. The MP4 file won't play. It is there so the demo has a real path with a video MIME type.

## Run

```
GLASS_BOX_MODE=offline bin/demo 06
```

You can also run `ruby demos/06-attachments/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/attachments/

Guided lesson: `guided/lessons/06-attachments.md`
