defmodule Frettchen.Reporter.Sender do
  @moduledoc """
  The Sender module takes a span and its 
  associated Trace configuration from a
  remote reporter and sends it either to 
  a UDP port in case the Trace is configured
  for an Agent, or a TCP port in case the 
  Trace is configured for a collector.
  """
  alias Frettchen.{Configuration, Trace}
  alias Jaeger.Thrift.{Agent, Batch, Process, Span, Tag}

  def start_link({span_id, trace}) do
    span = trace.spans[span_id]
    target = trace.configuration.target
    payload = prepare_payload(span, trace, target)
    Task.start_link(fn -> 
      send(payload, target, trace.configuration)
    end)
  end

  defp prepare_batch(%Span{} = span, %Trace{} = trace) do
    process = %{
      Process.new() |
      service_name: trace.service_name,
      tags: prepare_tags()
    }

    %{
      Batch.new() |
      process: process,
      spans: [span]
    }
  end

  defp prepare_payload(%Span{} = span, %Trace{} = trace, :agent) do
    emit_batch = %{
      Agent.EmitBatchArgs.new() |
      batch: prepare_batch(span, trace)
    }

    emit_batch
    |> Agent.EmitBatchArgs.serialize() 
    |> IO.iodata_to_binary()
  end

  defp prepare_payload(%Span{} = span, %Trace{} = trace, :collector) do
    span
    |> prepare_batch(trace)
    |> Batch.serialize() 
    |> IO.iodata_to_binary()
  end

  defp prepare_tags() do
    version_tag = %{
      Tag.new |
      key: "client.version",
      v_str: "Elixir Frettchen #{Application.spec(:frettchen, :vsn)}",
      v_type: 0 
    }
    [version_tag]
  end

  defp send(data, :agent, %Configuration{} = configuration) do
    {:ok, server} = :gen_udp.open(0)
    agent_host = String.to_charlist(configuration.agent_host)
    message = Thrift.Protocol.Binary.serialize(
      :message_begin, 
      {
        :oneway, 
        Frettchen.Helpers.current_time(), 
        "emitBatch"
      }
    )
    :gen_udp.send(
      server, 
      agent_host,
      configuration.agent_port,
      [message | data]
    )
    :gen_udp.close(server)
    {:ok, :sent}
  end

  defp send(data, :collector, %Configuration{} = configuration) do
    options = [{"Content-Type", "application/x-thrift"}] ++ configuration.http_options
    case HTTPoison.post(
      "#{configuration.collector_host}:#{configuration.collector_port}/api/traces?format=jaeger.thrift",
      data,
      options
    ) do
      {:ok, %HTTPoison.Response{status_code: 202}} ->
        {:ok, :sent}
      _ ->
        {:error, "Error sending data to collector"}
    end
  end
end
