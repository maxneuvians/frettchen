defmodule Frettchen.SpanTest do
  use ExUnit.Case, async: true

  alias Frettchen.Span

  describe "closing a span" do

    test "close/1 closes a span and calculates the duration" do
      span = Span.open("foo")
      span = Span.close(span)
      assert span.duration > 0
    end

  end

  describe "opening a span" do

    test "open/1 creates a new span struct with a passed name" do
      span = Span.open("foo")
      assert span.operation_name == "foo"
      refute span.trace_id_low == nil
      assert span.trace_id_high == 0
      refute span.span_id == nil
      assert span.parent_span_id == 0
      assert span.flags == 1
      refute span.start_time == nil
      assert span.duration == nil
      assert span.logs == []
      assert span.tags == []
    end

    test "open/2 creates a new span struct with a passed name and a passed span as the parent" do
      parent = Span.open("foo")
      span = Span.open("bar", parent)
      assert span.span_id != parent.span_id
      assert span.parent_span_id == parent.span_id
      assert span.trace_id_low == parent.trace_id_low
    end

    test "open/2 creates a new span struct with a passed name and a passed trace as the trace id" do
      trace = %Frettchen.Trace{} |> Frettchen.Trace.generate_id()
      span = Span.open("foo", trace)
      assert span.trace_id_low == trace.id
    end
  end

  describe "add a tag to a span" do

    setup do
      {:ok, span: Span.open("foo")} 
    end

    test "tag/3 adds a new tag with a string value", %{span: span} do
      span = Span.tag(span, "foo", "bar")
      tag = hd(span.tags)
      assert tag.key == "foo"
      assert tag.v_str == "bar"
      assert tag.v_type == 0
    end
  end
end
