# 17. Image and video generation

This demo uses the tour's red panda prompt and saves its files in `tmp/demos/17-image-video-generation`. `paint` and `animate` use fixtures unless the demo runs live with `GLASS_BOX_PAID_MEDIA=1`. In that case, `paint` needs OpenAI or a `RUBYLLM_IMAGE_MODEL`, and `animate` needs `XAI_API_KEY`. The fixture PNG is one pixel, and the fixture video won't play.

## Run

```
GLASS_BOX_MODE=offline bin/demo 17
```

You can also run `ruby demos/17-image-video-generation/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/image-generation/

Guided lesson: `guided/lessons/17-image-video-generation.md`
