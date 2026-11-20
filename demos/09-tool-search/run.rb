#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "09  Tool search and an MCP App approval"

# Gemini's wire format has no provider tool search, so a deferred chat adds
# RubyLLM's tool_search tool. OpenAI and Anthropic search on the provider side
# and do not add that local tool. The tour's card is the provider-side search.

class ListTitles < RubyLLM::Tool
  description "List fictional catalog titles"

  def execute(company:)
    catalog = GlassBox::Catalog.load
    row = catalog.find_company(company) or return { error: "no fictional company #{company}" }
    row.titles.map { |title| { title: title.name, platform: row.platform, episodes: title.episodes } }
  end
end

class CreateCatalogNote < RubyLLM::Tool
  description "Record a note on a fictional title"
  requires_approval

  def execute(title:, note:)
    { recorded: true, title: title, note: note }
  end
end

GlassBox.script_replies(
  GlassBox.tool_call(:tool_search, query: "select:create_catalog_note"),
  GlassBox.tool_call(:create_catalog_note, title: "The Last Lantern", note: "Public logline only."),
  cost: 0.003
)

base = if GlassBox.provider_configured?(:gemini)
         GlassBox.chat(model: "gemini-3.7-flash", provider: :gemini)
       else
         puts "Gemini is not configured, so this run uses the default chat model."
         GlassBox.chat
       end
chat = GlassBox.watch(base.with_tools(ListTitles, CreateCatalogNote, defer: true))
GlassBox.log "model", "#{chat.model.id} provider=#{chat.model.provider}"
GlassBox.log "deferred tools", chat.deferred_tools.keys.inspect
prompt = "Add a catalog note for The Last Lantern."
GlassBox.log "prompt", prompt
response = chat.ask prompt
question = chat.pending_questions.first
if question
  call = question.tool_call
  puts "APPROVAL NEEDED"
  puts "#{call.name} #{call.arguments.inspect}"
  puts "[Deny] [Approve]"
  if GlassBox.approved?
    GlassBox.script_replies "The catalog note was recorded.", cost: 0.003
    question.approve
    puts "approved"
  else
    GlassBox.script_replies "The catalog note was not recorded.", cost: 0.003
    question.decline("Not approved in this run")
    puts "declined"
  end
  response = chat.complete
end
GlassBox.log "reply", response.content
GlassBox.print_transcript(chat)
GlassBox.print_cost(chat)
