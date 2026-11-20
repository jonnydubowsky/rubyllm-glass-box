# 07. A Ruby tool the model can call

## The concept

A tool is a Ruby class that the model can call. The class has a description and an `execute` method. When you don't declare parameters yourself, this gem uses the keyword names of `execute` as the parameter schema. `with_tools` registers the class on a chat.

When the model calls the tool, the gem runs `execute` and sends the result back to the model. The model then writes its reply from that result. The tour's example is a weather tool with `execute(latitude:, longitude:)`.

## What this step does

The guided tool is `CatalogLookup`, and the step asks: "How many episodes does Salt Wedding have, and who publishes it?" The prompt holds neither answer, so the model has to call the tool. In the scripted run, the model calls `catalog_lookup` with the name Salt Wedding. The tool reads the catalog and returns the company Harbor and Thorn, the platform Harbor, 24 episodes and the logline. The assistant's next sentence restates that hash.

## What to look at

Read `[tool call]`, `[tool result]` and then the transcript. The episode count to trust is in the tool result, and the sentence after it repeats the number. The last line prints the same lookup done in plain Ruby.

## Run

```
bin/learn 7
GLASS_BOX_MODE=offline bin/demo 7
```

`bin/learn 7` prints this lesson and then runs the step. `bin/demo 7` runs the standalone demo in `demos/07-tools-weather`.

Docs: https://rubyllm.com/tools/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
