defmodule Frettchen.Reporter.Remote do
  @moduledoc """
  A ConsumerSupervisor that acts as the 
  Remote Reporter for Spans. Once a Span is sent
  to the Remote Reporter, the Consumer Supervisor
  will start a new process that handles the sending
  of the data to the UDP or TCP port.
  """
  use ConsumerSupervisor

  def init(args), do: {:consumer, args}

  def start_link() do
    children = [worker(Frettchen.Reporter.Sender, [], restart: :temporary)]
    opts = [strategy: :one_for_one, subscribe_to: [{Frettchen.Collector, partition: :remote}], name: __MODULE__]
    ConsumerSupervisor.start_link(children, opts)
  end
end
