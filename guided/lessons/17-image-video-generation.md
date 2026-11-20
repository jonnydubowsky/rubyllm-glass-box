# 17. Image and video generation

`RubyLLM.paint` and `RubyLLM.animate` bill the provider as soon as they run, and a video render waits. This course does not call them just because a chat key exists.

Set `GLASS_BOX_PAID_MEDIA=1` and `GLASS_BOX_MODE=live` to paint. Paint uses OpenAI unless `RUBYLLM_IMAGE_MODEL` names another model. Animate also needs `XAI_API_KEY`, because the default video model is on xAI.

Without those, paint saves a one-pixel PNG and animate saves a text stand-in. Both logs say the provider was not called. Look at byte size and `model=offline-fixture` before you treat the file as a picture.

## Run

```
bin/learn run 17
ruby demos/17-image-video-generation/run.rb
```

Docs: https://rubyllm.com/image-generation/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
