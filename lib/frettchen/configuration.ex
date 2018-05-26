defmodule Frettchen.Configuration do
  @moduledoc """
  A configuration struct that gets passed into the 
  Trace. The default configuration is to report
  spans to a Jaeger agent running on the localhost.

  ## Examples
    iex> %Frettchen.Configuration{}
    %Frettchen.Configuration{agent_host: "localhost", agent_port: 6832, collector_host: "localhost", collector_port: 14268, http_options: [], reporter: :remote, target: :agent}
  """

  defstruct agent_host: "localhost", agent_port: 6832, collector_host: "localhost", collector_port: 14_268, 
            http_options: [], reporter: :remote, target: :agent
end
