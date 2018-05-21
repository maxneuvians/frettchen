defmodule Frettchen.Reporter.Logging do
  @moduledoc """
  This is the logging reporter module for
  traces. It acts as a Consumer for the
  Collector producer and listens to the logging
  partition. Anything this consumer receives is
  logged at the info level. Logging is surpressed in
  MIX_ENV=test. 
  """
  use GenStage
  require Logger

  def start_link() do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_args) do
    {:consumer, :state, subscribe_to: [{Frettchen.Collector, partition: :logging}]}
  end

  def handle_events([{span_id, trace} | _], _from, state) do
    trace_id = trace.id
    service_name = trace.service_name
    span = trace.spans[span_id]
    operation_name = span.operation_name
    timestamp = span.start_time
    parent_id = if(span.parent_span_id != 0, do: span.parent_span_id, else: false)
    log_count = length(span.logs)
    tag_count = length(span.tags)
    Logger.info("""
      Logged span for operation #{operation_name} with ID #{span_id} inside Trace with ID #{trace_id} for service #{service_name}.
      Span was started at #{timestamp} and completed #{span.duration} microseconds later with #{log_count} logs and #{tag_count} tags.
      #{if(parent_id, do: "The span has a parent with id: #{span.parent_id}")}
      """)
    {:noreply, [], state}
  end
end
