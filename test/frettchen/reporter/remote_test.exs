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
  end
end
