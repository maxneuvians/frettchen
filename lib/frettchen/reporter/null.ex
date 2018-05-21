defmodule Frettchen.Reporter.Null do
  @moduledoc """
  This is the null reporter module for
  traces. It acts as a Consumer for the
  Collector producer and listens to the null
  partition. Anything this consumer receives is
  dispatched to the abyss. Usefull for testing.
  """
  use GenStage

  def start_link() do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_args) do
    {:consumer, :state, subscribe_to: [{Frettchen.Collector, partition: :null}]}
  end

  def handle_events(_spans, _from, state) do
    {:noreply, [], state}
  end
end
