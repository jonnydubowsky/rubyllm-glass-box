# frozen_string_literal: true

module GlassBox
  # Records RubyLLM instrumentation events. OpenTelemetry spans are built from
  # the same events when RubyLLM::OpenTelemetry.enable has been called.
  class Trace
    def initialize
      @events = []
      @stack = []
    end

    def instrument(name, payload)
      started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      @stack << name
      yield
    ensure
      @stack.pop
      elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started
      @events << { name: name, seconds: elapsed.round(4), workflow: payload[:workflow_name], step: payload[:workflow_step_name] }
    end

    def events
      @events.dup
    end

    def self.record
      GlassBox.boot!
      tracer = new
      RubyLLM::Support::Instrumentation.subscribe(tracer)
      yield tracer
    ensure
      RubyLLM::Support::Instrumentation.unsubscribe(tracer) if tracer
    end

    def self.enable_opentelemetry!
      GlassBox.boot!
      RubyLLM::OpenTelemetry.enable
      true
    rescue LoadError => error
      warn "OpenTelemetry was not enabled: #{error.message}"
      false
    end

    def print
      puts "[trace]"
      events.each do |event|
        label = [event[:workflow], event[:step], event[:name]].compact.join(" / ")
        puts format("  %-72s %6.3f s", label, event[:seconds])
      end
      puts
    end
  end
end
