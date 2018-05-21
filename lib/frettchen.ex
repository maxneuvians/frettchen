defmodule Frettchen do
  @moduledoc """
  Documentation for Frettchen.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Frettchen.hello
      :world

  """
  def hello do
    require Jaeger.Thrift.TagType
    version_tag = Jaeger.Thrift.Tag.new
    version_tag = %{ version_tag |
      key: "jaeger.version",
      v_str: "Elixir",
      v_type: Jaeger.Thrift.TagType.string
    }
    hostname_tag = Jaeger.Thrift.Tag.new
    hostname_tag = %{ hostname_tag |
      key: "hostname",
      v_str: "127.0.0.1",
      v_type: Jaeger.Thrift.TagType.string
    }
    span = Jaeger.Thrift.Span.new
    span = %{ span |
        operation_name: "foo",
        trace_id_low: 12387109925362352574,
        trace_id_high: 0,
        span_id: 15549390946617352406,
        flags: 1,
        start_time: Frettchen.Helpers.current_time(),
        duration: 10000,
        parent_span_id: 0
    }
    process = Jaeger.Thrift.Process.new
    process = %{ process | service_name: "Zip", tags: [version_tag, hostname_tag]}
    batch = Jaeger.Thrift.Batch.new
    batch = %{ batch |
      process: process,
      spans: [span]
    }
    data = Jaeger.Thrift.Batch.serialize(batch)
    |> IO.iodata_to_binary
    # emitBatch = Jaeger.Thrift.Agent.EmitBatchArgs.new
    # emitBatch = %{ emitBatch | batch: batch }
    # data = Jaeger.Thrift.Agent.EmitBatchArgs.serialize(emitBatch)
    # |> IO.iodata_to_binary
# {:ok, server} = :gen_udp.open(1337)
# message = Thrift.Protocol.Binary.serialize(:message_begin, {:oneway, 12, "emitBatch"})
#:gen_udp.send(server, '127.0.0.1', 6832, [message | data])
#:gen_udp.close(server)
HTTPoison.post "http://127.0.0.1:14268/api/traces?format=jaeger.thrift", data, [{"Content-Type", "application/x-thrift"}]    

  end
end
