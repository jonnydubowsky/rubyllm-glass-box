# frozen_string_literal: true

ENV["GLASS_BOX_MODE"] = "offline"
ENV["GLASS_BOX_APPROVE"] = "yes"

require "minitest/autorun"
require "open3"
require_relative "../lib/glass_box"

module GlassBoxTest
  module_function

  def run_ruby(*args, env: {}, unset: [])
    merged = ENV.to_h.merge("GLASS_BOX_MODE" => "offline").merge(env)
    unset.each { |key| merged.delete(key) }
    Open3.capture2e(merged, "bundle", "exec", "ruby", *args, chdir: GlassBox::ROOT.to_s)
  end
end
