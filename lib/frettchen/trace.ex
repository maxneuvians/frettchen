defmodule Frettchen.Trace do 
  use GenServer
  alias Frettchen.Trace
  alias Jaeger.Thrift.Span

  @moduledoc """
  """
  defstruct configuration: nil, id: nil, service_name: nil, spans: %{}
  
  # Public API
  @doc """
  Starts a new Trace process with a passed service name and options for a 
  custom id and configuration
  """
  def start(service_name, options \\ []) do
    configuration = Keyword.get(options, :configuration, %Frettchen.Configuration{})
    id = Keyword.get(options, :id, Frettchen.Helpers.random_id())
    trace = %{ %Trace{} | configuration: configuration, id: id, service_name: service_name}
    {:ok, _} = GenServer.start_link(__MODULE__, trace, name: {:global, {:frettchen, trace.id}})
    trace
  end

  def add_span(span = %Span{}) do
    GenServer.cast({:global, {:frettchen, span.trace_id_low}}, {:add_span, span})
    span
  end
  
  def get(span = %Span{}) do
    get(span.trace_id_low)
  end

  def get(id) do
    case :global.whereis_name({:frettchen, id}) do
      :undefined -> :undefined
      pid -> :sys.get_state(pid)
    end
  end

  def resolve_span(span = %Span{}) do
    GenServer.cast({:global, {:frettchen, span.trace_id_low}}, {:resolve_span, span})
  end
 
  def spans(trace = %Trace{}) do
    GenServer.call({:global, {:frettchen, trace.id}}, :spans)
  end

  # Private API
  def init(state) do
    {:ok, state}
  end

  def handle_call(:spans, _from, trace) do
    {:reply, trace.spans, trace}
  end

  def handle_cast({:add_span, span}, trace) do
    {:noreply, %{trace | spans: Map.merge(trace.spans, Map.put(%{}, span.span_id, span))}}
  end
  
end
