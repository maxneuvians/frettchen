defmodule Frettchen.Configuration do
  @moduledoc """
  A configuration struct that gets passed into the 
  Reporter. The default configuration is to report
  spans to a Jaeger agent running on the localhost.

  ## Examples
    iex> %Frettchen.Configuration{}
    %Frettchen.Configuration{agent_host: "localhost", agent_port: 6832, reporter: :remote}
  """

  defstruct agent_host: "localhost", agent_port: 6832, reporter: :remote
end
