defmodule Frettchen.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Frettchen.Collector, []),
      worker(Frettchen.Reporter.Logging, []),
      worker(Frettchen.Reporter.Null, []),
      worker(Frettchen.Reporter.Remote, [])
    ]

    opts = [strategy: :one_for_one, name: Frettchen.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
