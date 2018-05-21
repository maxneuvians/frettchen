defmodule Frettchen.Reporter.Remote do
  use ConsumerSupervisor

  def init(args), do: {:consumer, args}

  def start_link() do
    children = [worker(Frettchen.Reporter.Sender, [], restart: :temporary)]
    opts = [strategy: :one_for_one, subscribe_to: [{Frettchen.Collector, partition: :remote}], name: __MODULE__ ]
    ConsumerSupervisor.start_link(children, opts)
  end
end
