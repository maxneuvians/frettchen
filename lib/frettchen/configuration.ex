defmodule Frettchen.Configuration do
  @moduledoc """
  A configuration struct that gets passed into the 
  Trace. The default configuration is to report
  spans to a Jaeger agent running on the localhost.

  ## Examples
    iex> %Frettchen.Configuration{}
    %Frettchen.Configuration{agent_host: "localhost", agent_port: 6832, collector_host: "localhost", collector_port: 14268, local_udp_port: 16667, reporter: :remote, target: :agent}
  """

  defstruct agent_host: "localhost", agent_port: 6832, collector_host: "localhost", collector_port: 14268, local_udp_port: 16667,
            reporter: :remote, target: :agent
end
