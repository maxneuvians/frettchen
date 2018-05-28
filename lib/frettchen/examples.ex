defmodule Frettchen.Examples do
  @moduledoc """
  Compilatation of example code.
  """

  alias Frettchen.{Span, Trace}
  
  def simple_trace() do
    Trace.start("foo")
    |> Span.open("bar")
    |> Span.close()
  end

  def parent_span() do
    span = Trace.start("foo")
           |> Span.open("bar")
      
    child_span = Span.open(span, "biz")
    Span.close(child_span)
    Span.close(span)
  end

  def add_log() do
    Trace.start("foo")
    |> Span.open("bar")
    |> Span.log("fiz", "biz")
    |> Span.close()
  end

  def tag_span() do
    Trace.start("foo")
    |> Span.open("bar")
    |> Span.tag("fiz", "biz")
    |> Span.close()
  end

  def timeout_span() do
    Trace.start("foo", [timeout: 1000])
    |> Span.open("bar")
  end

  def explicit_start() do
    trace = Trace.start("foo")
    span = Span.open(trace, "bar")
    data = Span.inject(span)
    IO.inspect(data)
    ids = Span.extract(data)

    explicit_trace = Trace.get(ids.trace_id_low)
    explicit_span = explicit_trace.spans[ids.span_id]
    Span.close(explicit_span)

  end
end
