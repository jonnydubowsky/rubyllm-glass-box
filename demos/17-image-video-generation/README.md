# 17. Image and video generation

This demo uses the tour's red panda prompt and saves its files in `tmp/demos/17-image-video-generation`. `paint` and `animate` use fixtures unless the demo runs live with `GLASS_BOX_PAID_MEDIA=1`. In that case, `paint` needs OpenAI or a `RUBYLLM_IMAGE_MODEL`, and `animate` needs `XAI_API_KEY`. The fixture PNG is one pixel, and the fixture video won't play.

## Run

```
GLASS_BOX_MODE=offline bin/demo 17
```

You can also run `ruby demos/17-image-video-generation/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run generates nothing unless you also set `GLASS_BOX_PAID_MEDIA=1`. With that flag, the demo sends one image request to OpenAI, or to the model in `RUBYLLM_IMAGE_MODEL`, and one video request to xAI. Both providers charge as soon as the request runs.

## What to look at

The `[fixture]` or `[provider]` lines say whether each call reached a provider. The `[image]` and `[video]` lines give the path, the model and the size of each file. Offline, the model is `offline-fixture`, the PNG is 70 bytes and the video file is 38 bytes of text.

Docs: https://rubyllm.com/image-generation/

Guided lesson: `guided/lessons/17-image-video-generation.md`
