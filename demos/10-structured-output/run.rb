#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "10  Structured output"

# The tour subclasses Schematist::Schema. ruby_llm 2.2.3 still accepts that
# class in with_schema. There is no RubyLLM::Schema in this release.
class ProductSchema < Schematist::Schema
  string :name
  number :price
  array :features do
    string
  end
end

parsed = {
  "name" => "Ruby Mug",
  "price" => 18.0,
  "features" => ["Ceramic", "12 oz", "Dishwasher safe"]
}
GlassBox.script_replies JSON.generate(parsed), cost: 0.002
path = GlassBox::ROOT.join("demos/fixtures/product.txt")
chat = GlassBox.watch(GlassBox.chat.with_schema(ProductSchema))
response = chat.ask "Analyze this product", with: path.to_s
GlassBox.log "source", File.read(path)
GlassBox.log "response.parsed", response.parsed.inspect
GlassBox.print_cost(chat)
