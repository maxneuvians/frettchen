defmodule Frettchen.Collector do
  use GenStage

  def start_link() do
    queues = %{
      logging: :queue.new(),
      remote: :queue.new()
    }
    GenStage.start_link(__MODULE__, queues, name: Collector)
  end

  def init(queues) do
    {:producer, queues}
  end

  def handle_demand(demand, queues) do
    IO.inspect(demand)
    {:noreply, [], queues}
  end
end

