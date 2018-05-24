defmodule Frettchen.Reporter.RemoteTest do
  use ExUnit.Case, async: true

  alias Frettchen.Trace
  alias Frettchen.Reporter.Remote

  setup do
    pid = Process.whereis(Remote)
    {:ok, %{pid: pid}}
  end

  describe "start_link()" do
    test "starts a process", %{pid: pid} do
      assert is_pid(pid)
    end

    test "subscribes to Frettchen.Collector's remote partition", %{pid: pid} do
      collector = Process.whereis(Frettchen.Collector)
      state = :sys.get_state(pid)
      assert [{^collector, :permanent, _}] = Map.values(state.producers)
    end
  end

  describe "hande_events/3" do
    test "sends spans received from Frettchen.Collector", %{pid: pid} do
      trace = Trace.start("foo", [configuration: %{%Frettchen.Configuration{} | agent_port: 32_409}])
      span = Frettchen.Span.open(trace, "bar")
      :erlang.trace(pid, true, [:receive])
      span = Frettchen.Span.close(span)
      id = span.span_id
      assert_receive {:trace, ^pid, :receive, {:"$gen_consumer", _, [{^id, %Trace{}}]}} 
    end

    test "sends spans received from Frettchen.Collector to a udp port"  do
      trace = Trace.start("foo", [configuration: %{%Frettchen.Configuration{} | agent_port: 32_409}])
      Frettchen.Span.open(trace, "bar")
        |> Frettchen.Span.close()

      udp_server = Process.whereis(Frettchen.TestUdpServer) 
      :erlang.trace(udp_server, true, [:receive])
      assert_receive {:trace, ^udp_server, :receive, {:inet_async, _, _, _}} 
    end
    
    test "sends spans received from Frettchen.Collector to a tcp port"  do
      trace = Trace.start("foo", [configuration: %{%Frettchen.Configuration{} | collector_port: 32_509, target: :collector}])

      Frettchen.Span.open(trace, "bar")
        |> Frettchen.Span.close()

      tcp_server = Process.whereis(Frettchen.TestTcpServer) 
      :erlang.trace(tcp_server, true, [:receive])
      assert_receive {:trace, ^tcp_server, :receive, {:inet_async, _, _, _}} 
    end
  end
end
