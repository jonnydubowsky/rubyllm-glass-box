#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "25  Compaction and the agentic loop"

class LookupTitle < RubyLLM::Tool
  description "Look up a fictional title"

  def execute(name:)
    found = GlassBox::Catalog.load.find_title(name)
    return { error: "no title" } unless found

    company, title = found
    { title: title.name, platform: company.platform, episodes: title.episodes }
  end
end

GlassBox.script_replies(
  GlassBox.tool_call(:lookup_title, name: "The Last Lantern"),
  "The Last Lantern has 48 episodes on Lantern.",
  cost: 0.002
)
chat = GlassBox.watch(GlassBox.chat.with_tools(LookupTitle).with_compaction(at: 50_000))
GlassBox.log "compaction", chat.compaction.inspect
chat.ask_later "How many episodes does The Last Lantern have?"
steps = 0
until chat.complete? || chat.waiting? || steps > 6
  steps += 1
  message = chat.step
  state = if chat.waiting?
            "waiting"
          elsif chat.complete?
            "complete"
          else
            "running"
          end
  puts "step #{steps} state=#{state} role=#{message&.role} content=#{message&.content.to_s[0, 80].inspect}"
end
puts
puts "The tour's card labels the loop think, act, observe. Each chat.step call above ran one of those parts."
puts "The loop stops when chat.complete? or chat.waiting? returns true."
puts
GlassBox.print_cost(chat)
