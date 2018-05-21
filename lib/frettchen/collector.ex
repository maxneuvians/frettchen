defmodule Frettchen.Collector do
  use GenStage

  @doc """
  Starts the collector
  """
  def start_link() do
    GenStage.start_link(__MODULE__, 0, name: __MODULE__)
  end

  @doc """
  Adds a span to the collector for distribution
  """
  def add(span) do
    GenStage.call(__MODULE__, {:notify, span})
  end

  def init(total) do
    {
      :producer, 
      total, 
      dispatcher: {
        GenStage.PartitionDispatcher, 
        partitions: [:logging, :null, :remote], 
        hash: &set_partition(&1)
      }
    }
  end

  def handle_call({:notify, span}, _from, total) do
    {:reply, :ok, [span], total + 1}
  end

  def handle_demand(_demand, state) do
    {:noreply, [], state}
  end

  defp set_partition({span_id, trace}) do
    {{span_id, trace}, trace.configuration.reporter}
  end
end
