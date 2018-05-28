defmodule Frettchen.TraceTest do
  use ExUnit.Case, async: true
  doctest Frettchen.Trace

  alias Frettchen.Trace

  describe "start/1" do
    test "returns a trace struct with the passed name as the service name" do
      trace = Trace.start("foo")
      assert trace.service_name == "foo"
    end

    test "generates a random id if non is added in the options" do
      trace = Trace.start("foo")
      refute trace.id == nil 
    end

    test "uses the id from options to set the trace id" do
      trace = Trace.start("foo", [id: "bar"])
      assert trace.id == "bar"
    end

    test "uses the configuration from options to set a different configuration" do
      configuration = %{%Frettchen.Configuration{} | reporter: :log}
      trace = Trace.start("foo", [configuration: configuration])
      assert trace.configuration.reporter == :log
    end

    test "creates a process that is registered in the global name space with the id" do
      assert Trace.get("bar") == :undefined
      Trace.start("foo", [id: "bar"])
      refute Trace.get("bar") == :undefined
    end
  end

  describe "add_span/1" do
    test "adds a span struct to a trace process based on the trace_id_low in the span" do
      Trace.start("foo", [id: "bar"])
      span =
        %{Jaeger.Thrift.Span.new() | 
          trace_id_low: "bar",
          span_id: "foo"
        } 
      Trace.add_span(span)
      trace = Trace.get("bar") 
      assert trace.spans["foo"] == span
    end
  end

  describe "get/1" do
    test "returns undefined if the Trace process does not exist" do
      assert Trace.get("foo") == :undefined
    end

    test "returns trace struct if the Trace process exist" do
      trace = Trace.start("foo")
      assert Trace.get(trace.id) == trace
    end

    test "retuns a trace struct from a passed span" do
      Trace.start("foo", [id: "bar"])
      span =
        %{Jaeger.Thrift.Span.new() | 
          trace_id_low: "bar",
          span_id: "foo"
        } 
      refute Trace.get(span) == :undefined
    end
  end

  describe "resolve_span/1" do
    setup do
      Trace.start("foo", [id: "bar", configuration: %{%Frettchen.Configuration{} | reporter: :null}])
      span =
        %{Jaeger.Thrift.Span.new() | 
          trace_id_low: "bar",
          span_id: "foo"
        } 
      Trace.add_span(span)
      trace = Trace.get("bar") 
      {:ok, %{span: span, trace: trace}}
    end

    test "removes a span struct from a trace process based on the trace_id_low in the span and the span_id", %{span: span} do
      Trace.resolve_span(span)
      trace = Trace.get("bar") 
      refute trace.spans["foo"] == span
    end

    test "sends a span to Frettchen.Collector for further processing", %{span: span} do
      pid = Process.whereis(Frettchen.Collector)
      :erlang.trace(pid, true, [:receive])
      Trace.resolve_span(span)
      id = span.span_id
      assert_receive {:trace, ^pid, :receive, {:"$gen_call", _, {:notify, {^id, %Trace{}}}}} 
    end
  end

  describe "shutdown process" do
    test "a trace shutsdown after a give timeout" do
      trace = Trace.start("foo", [timeout: 100])
      Process.sleep(200)
      assert Trace.get(trace.id) == :undefined
    end

    test "closes all remaining spans" do
      t = Trace.start("foo", [timeout: 200])
      span = Frettchen.Span.open(t, "bar")
      pid = Process.whereis(Frettchen.Collector)
      :erlang.trace(pid, true, [:receive])
      id = span.span_id
      Process.sleep(200) 
      assert_receive {:trace, ^pid, :receive, {:"$gen_call", _, {:notify, {^id, %Trace{}}}}} 
    end
  end

  describe "spans/0" do
    test "returns a map of spans for a passed trace" do
      Trace.start("foo", [id: "bar"])
      span =
        %{Jaeger.Thrift.Span.new() | 
          trace_id_low: "bar",
          span_id: "foo"
        } 
      Trace.add_span(span)
      trace = Trace.get("bar")
      assert trace.spans == %{"foo" => span}
    end
  end
end
