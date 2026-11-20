# 17. Image and video generation

## The concept

`RubyLLM.paint` returns an image for a prompt, and `RubyLLM.animate` returns a video. Each result has a `save` method and a `model` attribute. Both calls charge your provider account as soon as they run, and a video render takes time.

## What this step does

The step sends one prompt to both calls: "A paper lantern over a night market, flat illustration, no text". This course doesn't call either provider just because a chat key is set. To paint, set `GLASS_BOX_PAID_MEDIA=1` and `GLASS_BOX_MODE=live`. `paint` uses OpenAI when an OpenAI key is set, and otherwise the model that `RUBYLLM_IMAGE_MODEL` names. `animate` also needs `XAI_API_KEY`, because the default video model runs on xAI.

Without those settings, `paint` saves a one-pixel PNG, `animate` saves a text stand-in, and both logs say the step didn't call the provider.

## What to look at

Read the two `[fixture]` or `[provider]` lines. Then read the byte size and `model=` on the `[image]` and `[video]` lines. A size of 70 bytes and `model=offline-fixture` mean the image file is a stand-in.

## Run

```
bin/learn 17
GLASS_BOX_MODE=offline bin/demo 17
```

`bin/learn 17` prints this lesson and then runs the step. `bin/demo 17` runs the standalone demo in `demos/17-image-video-generation`.

Docs: https://rubyllm.com/image-generation/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
