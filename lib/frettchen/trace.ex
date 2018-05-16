defmodule Frettchen.Trace do 
  use GenServer
  alias Frettchen.Trace
  alias Jaeger.Thrift.Span

  @moduledoc """
  """
  defstruct id: nil, service_name: nil, spans: []

  # Public API

  @doc """
  Starts a new Trace process
  """
  def start_link(configuration, id \\ nil) do
    trace = %{ %Trace{} | id: id}
    GenServer.start_link(__MODULE__, trace, name: {:global, trace.id})
  end

  def add_span(span = %Span{}) do
    GenServer.cast({:global, span.trace_id_low}, {:add_span, span})
  end

  def resolve_span(span = %Span{}) do
    GenServer.cast({:global, span.trace_id_low}, {:resolve_span, span})
  end

  @doc """
  Creates a random trace id if non exists

  ## Example
    iex> trace = %Frettchen.Trace{}
    ...> |> Frettchen.Trace.generate_id()
    ...> is_integer(trace.id)
    true
  """
  def generate_id(trace = %Trace{}) do
    if trace.id == nil do
      %{ trace | id: Frettchen.Helpers.random_id()}
    else
      trace
    end
  end

  # Private API
  def init(state) do
    {:ok, state}
  end
end
