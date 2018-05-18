defmodule Frettchen.Reporter.Logging do
  use GenStage

  def start_link() do
    GenStage.start_link(__MODULE__, :ok)
  end

  def init(_args) do
    send(self(), :init)
    {:consumer, :state}
  end

  def handle_info(:init, state) do
    GenStage.async_subscribe(self(), to: Collector, cancel: :temporary)
    {:noreply, [], state}
  end

  def handle_subscribe(:producer, _opts, from, state) do
    GenStage.ask(from, 1000)
    {:manual, state}
  end
  
  def handle_events(events, from, state) do
    GenStage.ask(from, 1000)
    {:noreply, state}
  end
end
