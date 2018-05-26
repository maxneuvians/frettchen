defmodule Frettchen.Reporter.NullTest do
  use ExUnit.Case, async: true

  alias Frettchen.Trace
  alias Frettchen.Reporter.Null

  setup do
    pid = Process.whereis(Null)
    {:ok, %{pid: pid}}
  end

  describe "start_link()" do
    test "starts a process", %{pid: pid} do
      assert is_pid(pid)
    end

    test "subscribes to Frettchen.Collector's null partition", %{pid: pid} do
      collector = Process.whereis(Frettchen.Collector)
      state = :sys.get_state(pid)
      assert [{^collector, :permanent, _}] = Map.values(state.producers)
    end
  end

  describe "hande_events/3" do
    test "does nothing with spans received from Frettchen.Collector", %{pid: pid} do
      trace = Trace.start("foo", [configuration: %{%Frettchen.Configuration{} | reporter: :null}])
      span = Frettchen.Span.open(trace, "bar")
      :erlang.trace(pid, true, [:receive])
      span = Frettchen.Span.close(span)
      id = span.span_id
      assert_receive {:trace, ^pid, :receive, {:"$gen_consumer", _, [{^id, %Trace{}}]}} 
    end
  end
end
