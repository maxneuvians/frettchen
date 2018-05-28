defmodule Frettchen.Reaper do
  @moduledoc """
  The Reaper is a process that a trace invokes when it 
  is preparing to shutdown due to its timeout configuration.
  As a trace needs to still close any remaining spans it
  cannot handle both the closing of spans and its own
  shutdown simultaneously. Instead the Repear handles the
  closing of spans and then sends an exit signal to the process
  and then itself.
  """
  use GenServer

  def start_link() do
   GenServer.start_link(__MODULE__, :ok)
  end

  def init(state) do
    {:ok, state}
  end

  def absolve(pid, trace) do
    GenServer.cast(pid, {:trace, trace})
  end

  def handle_cast({:trace, trace}, state) do
    Enum.each(trace.spans, fn {_id, span} ->
      span
        |> Frettchen.Span.log("Status", "Forced close due to trace timeout (#{trace.timeout} milliseconds)")
        |> Frettchen.Span.close()
    end)
    Frettchen.Trace.terminate(trace)
    Process.send_after(self(), :terminate, 100)
    {:noreply, state}
  end

  def handle_info(:terminate, state) do
    {:stop, :normal, :ok}
  end
end
