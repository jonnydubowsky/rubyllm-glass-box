# frozen_string_literal: true

module GlassBox
  # Records RubyLLM instrumentation events and prints them as an indented
  # waterfall. OpenTelemetry spans are built from the same events when
  # RubyLLM::OpenTelemetry.enable has been called.
  class Trace
    def initialize
      @events = []
      @depth = 0
      @started = 0
    end

    # RubyLLM calls this around each instrumented block. An event that starts
    # while another is running is printed one level deeper.
    def instrument(name, payload)
      started = clock
      order = (@started += 1)
      depth = @depth
      @depth += 1
      yield
    ensure
      @depth -= 1
      @events << {
        name: name,
        detail: detail(name, payload),
        depth: depth,
        order: order,
        seconds: (clock - started).round(4)
      }
    end

    # Events in the order they started.
    def events
      @events.sort_by { |event| event[:order] }
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
        label = "#{"  " * event[:depth]}#{event[:name]}  #{event[:detail]}".rstrip
        puts format("  %-62s %6.3f s", label, event[:seconds])
      end
      puts
    end

    private

    def clock
      Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end

    # The one field of the payload that says what this event was about.
    def detail(name, payload)
      case name.to_s
      when /\Aworkflow_step\./ then payload[:workflow_step_name]
      when /\Aworkflow\./ then payload[:workflow_name]
      when /\Atool_call\./ then payload[:tool_name]
      when /\Ausage\./ then payload[:operation]
      else payload[:model]
      end
    end
  end
end
