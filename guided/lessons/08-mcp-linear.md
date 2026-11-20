# 08. An MCP server declared as a Ruby class

## The concept

An MCP server offers tools to a model over the Model Context Protocol. In RubyLLM, you declare a server as a subclass of `RubyLLM::MCP`. The class sets a URL, an `inputs` owner and OAuth. `only` limits the tools the model can see, `requires_approval` makes a write tool wait for a person, and `extension :apps` turns on MCP App panels.

The tour declares a Linear server this way, and the current gem has the same class methods.

## What this step does

The step declares the tour's Linear class and prints its `only` list. It never opens `https://mcp.linear.app/mcp`. The server that runs is `GlassBox::CatalogMCP`. Its transport answers the MCP handshake inside the same process and lists fictional titles.

The step calls `list_titles` for Lantern Reel, and the server returns The Last Lantern on the platform Lantern, with 48 episodes. The `create_note` tool is marked `requires_approval`, and this step never calls it. No prompt goes to a model in this step.

## What to look at

Read the `only` list on the declared class, and then read the `list_titles` result. `bin/demo 8` also prints the local server's tool list, with a read-only flag on each tool.

## Run

```
bin/learn 8
GLASS_BOX_MODE=offline bin/demo 8
```

`bin/learn 8` prints this lesson and then runs the step. `bin/demo 8` runs the standalone demo in `demos/08-mcp-linear`.

Docs: https://rubyllm.com/mcp/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
