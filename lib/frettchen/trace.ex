defmodule Frettchen.Trace do 
  @moduledoc """
  A struct representing a complete trace 
  within one component. This includes a unique
  Trace ID and a list of all the associated
  spans. Includes convenience methods to 
  determin properties about a trace.

  ## Example
    iex> %Frettchen.Trace{}
    %Frettchen.Trace{id: nil, service_name: nil, spans: []}
  """
  defstruct id: nil, service_name: nil, spans: []

  @doc """
  Creates a random Trace ID

  ## Example
    iex> trace = %Frettchen.Trace{}
    ...> |> Frettchen.Trace.generate_id
    ...> is_integer(trace.id)
    true
  """
  def generate_id(trace = %Frettchen.Trace{}) do
    %{ trace | id: Frettchen.Helpers.random_id()}
  end
end
