# 16. Speech and transcription

This demo turns "Welcome to the show!" into speech, saves it as a WAV file and transcribes the file. Offline, the WAV file holds silence, and the transcript is the source sentence copied back. The log says the demo called neither provider. In live mode, speech uses OpenAI or ElevenLabs, and transcription uses OpenAI.

## Run

```
GLASS_BOX_MODE=offline bin/demo 16
```

You can also run `ruby demos/16-speech-transcription/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/text-to-speech/

Guided lesson: `guided/lessons/16-speech-transcription.md`
