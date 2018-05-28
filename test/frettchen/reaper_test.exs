defmodule Frettchen.ReaperTest do
  use ExUnit.Case, async: false
  alias Frettchen.Reaper

  describe "start_link/0" do
    test "start a reaper process" do
      {:ok, pid} = Reaper.start_link()
      assert is_pid(pid)
    end
  end

  describe "absolve/1" do
    test "terminates itself" do
      t = Frettchen.Trace.start("foo")
      {:ok, pid} = Reaper.start_link()
      Reaper.absolve(pid, t)
      Process.sleep(200)
      refute Process.alive?(pid)
    end
  end
end
