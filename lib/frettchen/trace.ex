defmodule Frettchen.Trace do 
  @moduledoc """
  A Trace is a process that collects spans. When a span 
  is created it registers with the process and when it is closed
  it removes itself from the process and gets sent
  to the reporter that is has been configured for. A Trace can be configured 
  to act differently based on need. This allows you to create some traces
  that get sent to Jaeger, and other that get logged or sent to null. 
  You can even configure the port numbers for your collectors so Traces
  can go to different collectors.
  """
  use GenServer
  alias Frettchen.Trace
  alias Jaeger.Thrift.Span

  defstruct configuration: nil, id: nil, service_name: nil, spans: %{}, timeout: nil
  
  # Public API

  @doc """
  Starts a new Trace process with a passed service name and options for a 
  custom id, configuration, and timeout in millieseconds. The current custom timeout 
  is 2 minutes (2 * 60 * 1000)
  """
  def start(service_name, options \\ []) do
    configuration = Keyword.get(options, :configuration, %Frettchen.Configuration{})
    id = Keyword.get(options, :id, Frettchen.Helpers.random_id())
    timeout = Keyword.get(options, :timeout, 120_000)
    trace = %{%Trace{} | configuration: configuration, id: id, service_name: service_name, timeout: timeout}
    {:ok, _} = GenServer.start_link(__MODULE__, trace, name: {:global, {:frettchen, trace.id}})
    trace
  end

  @doc """
  Adds a span to a trace based on the trace_id_low inside the
  span. This is largely a convenience function for allowing
  spans to be processed inside a pipe.
  """
  def add_span(%Span{} = span) do
    GenServer.cast({:global, {:frettchen, span.trace_id_low}}, {:add_span, span})
    span
  end
  
  @doc """
  Returns a trace processs based on the trace_low_id inside a span. Usefull 
  for getting a trace when a span is passed between functions.
  """
  def get(%Span{} = span) do
    get(span.trace_id_low)
  end

  @doc """
  Returns a trace process based on a passed ID. Usefull for getting
  a trace when just an ID reference is passed between process or
  microservices.
  """
  def get(id) do
    case :global.whereis_name({:frettchen, id}) do
      :undefined -> :undefined
      pid -> :sys.get_state(pid)
    end
  end

  @doc """
  Triggers the resolution of a span. A span is sent to the collector
  for distribution and then removed from the spans map inside the trace.
  """
  def resolve_span(%Span{} = span) do
    GenServer.call({:global, {:frettchen, span.trace_id_low}}, {:resolve_span, span})
    span
  end
 
  @doc """
  Returns a map of all the spans inside a trace.
  """
  def spans(%Trace{} = trace) do
    GenServer.call({:global, {:frettchen, trace.id}}, :spans)
  end

  @doc """
  Terminates the trace process 
  """
  def terminate(%Trace{} = trace) do
    GenServer.call({:global, {:frettchen, trace.id}}, :terminate)
  end

  # Private API
  def init(state) do
    Process.send_after(self(), :shutdown, state.timeout)
    {:ok, state}
  end

  def handle_call(:spans, _from, trace) do
    {:reply, trace.spans, trace}
  end

  def handle_call({:resolve_span, span}, _from, trace) do
    trace = %{trace | spans: Map.merge(trace.spans, Map.put(%{}, span.span_id, span))}
    Frettchen.Collector.add({span.span_id, trace})  
    {:reply, trace, %{trace | spans: Map.delete(trace.spans, span.span_id)}}
  end

  def handle_call(:terminate, _from, state) do
    {:stop, :normal, :ok, state}
  end
  
  def handle_cast({:add_span, span}, trace) do
    {:noreply, %{trace | spans: Map.merge(trace.spans, Map.put(%{}, span.span_id, span))}}
  end

  @doc """
  Starts the shutdown sequence after a timeout by spawning a reaper process
  that will close all the remaining spans and the send an exit signal to the
  trace.
  """
  def handle_info(:shutdown, state) do
    {:ok, pid} = Frettchen.Reaper.start_link()
    Frettchen.Reaper.absolve(pid, state)
    {:noreply, state}
  end

end
