defmodule Frettchen.Span do
  @moduledoc """
  Spans are data structures that collect information
  which gets sent to a reporter. They are usually
  initialized and added to a Trace process which can
  handle the life cycle management. Tags and logs
  can be added to Spans to provide additional information.
  Spans can also be injected (serialized) so that they can
  be passed between differnent microservices.
  """
  alias Jaeger.Thrift.{Log, Span, Tag}
  alias Frettchen.Trace

  @doc """
  close/1 closes a span by calculating the duration as the 
  difference between the start time and the current time
  """
  def close(%Span{} = span) do
    %{span | duration: (Frettchen.Helpers.current_time() - span.start_time)}
    |> Trace.resolve_span()
  end

  @doc """
  Extracts span data from a serialized inject
  """
  def extract(string) do
    [trace_id_low, span_id, parent_span_id, _bits] = String.split(string, ":")
    trace_id_low = 
      trace_id_low
      |> String.upcase()
      |> Integer.parse(16)
      |> elem(0)
    span_id = 
      span_id
      |> String.upcase()
      |> Integer.parse(16)
      |> elem(0)
    parent_span_id = 
      parent_span_id
      |> String.upcase()
      |> Integer.parse(16)
      |> elem(0)
    %{trace_id_low: trace_id_low, span_id: span_id, parent_span_id: parent_span_id}
  end

  @doc """
  Converts the data in a span into an injectable string
  """
  def inject(%Span{} = span) do
      "#{Integer.to_string(span.trace_id_low, 16)}:#{Integer.to_string(span.span_id, 16)}:#{Integer.to_string(span.parent_span_id,16)}:1"
  end

  @doc """
  log/3 adds a tag struct with a timestamp to the logs list of
  a span.
  """
  def log(%Span{} = span, key, value) when is_binary(key) do
    tag = 
      %{Tag.new | key: key} 
      |> tag_merge_value(value)
    
    log =
      %{Log.new | timestamp: Frettchen.Helpers.current_time(), fields: [tag]}

    %{span | logs: [log | span.logs]}
  end

  @doc """
  open/2 creates a new span with a given name and
  assigns the passed span as the parent_id. The span
  is then added to the Trace process
  """
  def open(%Span{} = span, name) do
    %{new_span(name) | trace_id_low: span.trace_id_low, parent_span_id: span.span_id}
    |> Trace.add_span()
  end
  
  @doc """
  open/2 creates a new span with a given name and
  assigns the passed trace as the trace_id. The span
  is then added to the Trace process
  """
  def open(%Trace{} = trace, name) do
    %{new_span(name) | trace_id_low: trace.id}
    |> Trace.add_span()
  end

  @doc """
  tag/3 adds a tag struct to the tags list of
  a span.
  """
  def tag(%Span{} = span, key, value) when is_binary(key) do
    tag = 
      %{Tag.new | key: key} 
      |> tag_merge_value(value)

    %{span | tags: [tag | span.tags]}
  end

  defp new_span(name) do
    %{Span.new() | 
      operation_name: Frettchen.Helpers.format_name(name),
      trace_id_low: 0,
      trace_id_high: 0,
      span_id: Frettchen.Helpers.random_id(),
      parent_span_id: 0,
      flags: 1,
      start_time: Frettchen.Helpers.current_time(),
      logs: [],
      tags: []
    } 
  end

  defp tag_merge_value(%Tag{} = tag, value) when is_binary(value) do
    %{tag | v_type: 0, v_str: value}
  end
  defp tag_merge_value(%Tag{} = tag, value) when is_float(value) do
    %{tag | v_type: 1, v_double: value}
  end
  defp tag_merge_value(%Tag{} = tag, value) when is_boolean(value) do
    %{tag | v_type: 2, v_bool: value}
  end
  defp tag_merge_value(%Tag{} = tag, value) when is_integer(value) do
    %{tag | v_type: 3, v_long: value}
  end
end
