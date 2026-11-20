# 17. Image and video generation

`RubyLLM.paint` and `RubyLLM.animate` charge your provider account as soon as they run, and a video render takes time. This course doesn't call them just because a chat key is set.

To paint, set `GLASS_BOX_PAID_MEDIA=1` and `GLASS_BOX_MODE=live`. `paint` uses OpenAI unless `RUBYLLM_IMAGE_MODEL` names another model. `animate` also needs `XAI_API_KEY`, because the default video model runs on xAI.

Without those settings, `paint` saves a one-pixel PNG, `animate` saves a text stand-in, and both logs say the step didn't call the provider. Check the byte size and `model=offline-fixture` before you treat either file as a picture.

## Run

```
bin/learn run 17
ruby demos/17-image-video-generation/run.rb
```

Docs: https://rubyllm.com/image-generation/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
