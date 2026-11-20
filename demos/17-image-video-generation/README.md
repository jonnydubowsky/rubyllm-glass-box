# 17. Image and video generation

The prompt is the tour's red panda. Files land in `tmp/demos/17-image-video-generation`. Paint and animate stay on fixtures unless `GLASS_BOX_PAID_MEDIA=1` and you are live. Paint then needs OpenAI, or `RUBYLLM_IMAGE_MODEL`. Animate needs `XAI_API_KEY`. The fixture PNG is one pixel. The fixture video is not playable.

## Run

```
ruby demos/17-image-video-generation/run.rb
```

Or `bin/demo 17`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/image-generation/

Guided lesson: `guided/lessons/17-image-video-generation.md`
