defmodule(Jaeger.Thrift.Agent) do
  defmodule(EmitBatchArgs) do
    _ = "Auto-generated Thrift struct Elixir.EmitBatchArgs"
    _ = "1: jaeger.Batch batch"
    defstruct(batch: nil)
    @type(t :: %__MODULE__{})
    def(new) do
      %__MODULE__{}
    end
    defmodule(BinaryProtocol) do
      @moduledoc(false)
      def(deserialize(binary)) do
        deserialize(binary, %EmitBatchArgs{})
      end
      defp(deserialize(<<0, rest::binary>>, %EmitBatchArgs{} = acc)) do
        {acc, rest}
      end
      defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
        case(Elixir.Jaeger.Thrift.Batch.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | batch: value})
          :error ->
            :error
        end
      end
      defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
        rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
      end
      defp(deserialize(_, _)) do
        :error
      end
      def(serialize(%EmitBatchArgs{batch: batch})) do
        [case(batch) do
          nil ->
            <<>>
          _ ->
            [<<12, 1::16-signed>> | Jaeger.Thrift.Batch.serialize(batch)]
        end | <<0>>]
      end
    end
    def(serialize(struct)) do
      BinaryProtocol.serialize(struct)
    end
    def(serialize(struct, :binary)) do
      BinaryProtocol.serialize(struct)
    end
    def(deserialize(binary)) do
      BinaryProtocol.deserialize(binary)
    end
  end
  defmodule(EmitZipkinBatchArgs) do
    _ = "Auto-generated Thrift struct Elixir.EmitZipkinBatchArgs"
    _ = "1: list<zipkincore.Span> spans"
    defstruct(spans: nil)
    @type(t :: %__MODULE__{})
    def(new) do
      %__MODULE__{}
    end
    defmodule(BinaryProtocol) do
      @moduledoc(false)
      def(deserialize(binary)) do
        deserialize(binary, %EmitZipkinBatchArgs{})
      end
      defp(deserialize(<<0, rest::binary>>, %EmitZipkinBatchArgs{} = acc)) do
        {acc, rest}
      end
      defp(deserialize(<<15, 1::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
        deserialize__spans(rest, [[], remaining, struct])
      end
      defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
        rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
      end
      defp(deserialize(_, _)) do
        :error
      end
      defp(deserialize__spans(<<rest::binary>>, [list, 0, struct])) do
        deserialize(rest, %{struct | spans: Enum.reverse(list)})
      end
      defp(deserialize__spans(<<rest::binary>>, [list, remaining | stack])) do
        case(Elixir.Jaeger.Thrift.Agent.Zipkin.Span.BinaryProtocol.deserialize(rest)) do
          {element, rest} ->
            deserialize__spans(rest, [[element | list], remaining - 1 | stack])
          :error ->
            :error
        end
      end
      defp(deserialize__spans(_, _)) do
        :error
      end
      def(serialize(%EmitZipkinBatchArgs{spans: spans})) do
        [case(spans) do
          nil ->
            <<>>
          _ ->
            [<<15, 1::16-signed, 12, length(spans)::32-signed>> | for(e <- spans) do
              Jaeger.Thrift.Agent.Zipkin.Span.serialize(e)
            end]
        end | <<0>>]
      end
    end
    def(serialize(struct)) do
      BinaryProtocol.serialize(struct)
    end
    def(serialize(struct, :binary)) do
      BinaryProtocol.serialize(struct)
    end
    def(deserialize(binary)) do
      BinaryProtocol.deserialize(binary)
    end
  end
  defmodule(Binary.Framed.Client) do
    @moduledoc(false)
    alias(Thrift.Binary.Framed.Client, as: ClientImpl)
    defdelegate(close(conn), to: ClientImpl)
    defdelegate(connect(conn, opts), to: ClientImpl)
    defdelegate(start_link(host, port, opts \\ []), to: ClientImpl)
    def(unquote(:emit_batch)(client, batch, rpc_opts \\ [])) do
      args = %EmitBatchArgs{batch: batch}
      serialized_args = EmitBatchArgs.BinaryProtocol.serialize(args)
      (
        :ok = ClientImpl.oneway(client, "emitBatch", serialized_args, rpc_opts)
        {:ok, nil}
      )
    end
    def(unquote(:emit_batch!)(client, batch, rpc_opts \\ [])) do
      case(unquote(:emit_batch)(client, batch, rpc_opts)) do
        {:ok, rsp} ->
          rsp
        {:error, {:exception, ex}} ->
          raise(ex)
        {:error, reason} ->
          raise(Thrift.ConnectionError, reason: reason)
      end
    end
    def(unquote(:emit_zipkin_batch)(client, spans, rpc_opts \\ [])) do
      args = %EmitZipkinBatchArgs{spans: spans}
      serialized_args = EmitZipkinBatchArgs.BinaryProtocol.serialize(args)
      (
        :ok = ClientImpl.oneway(client, "emitZipkinBatch", serialized_args, rpc_opts)
        {:ok, nil}
      )
    end
    def(unquote(:emit_zipkin_batch!)(client, spans, rpc_opts \\ [])) do
      case(unquote(:emit_zipkin_batch)(client, spans, rpc_opts)) do
        {:ok, rsp} ->
          rsp
        {:error, {:exception, ex}} ->
          raise(ex)
        {:error, reason} ->
          raise(Thrift.ConnectionError, reason: reason)
      end
    end
  end
  defmodule(Binary.Framed.Server) do
    @moduledoc(false)
    require(Logger)
    alias(Thrift.Binary.Framed.Server, as: ServerImpl)
    defdelegate(stop(name), to: ServerImpl)
    def(start_link(handler_module, port, opts \\ [])) do
      ServerImpl.start_link(__MODULE__, port, handler_module, opts)
    end
    def(handle_thrift("emitBatch", binary_data, handler_module)) do
      case(Elixir.Jaeger.Thrift.Agent.EmitBatchArgs.BinaryProtocol.deserialize(binary_data)) do
        {%Jaeger.Thrift.Agent.EmitBatchArgs{batch: batch}, ""} ->
          try() do
            rsp = handler_module.emit_batch(batch)
            (
              _ = rsp
              :noreply
            )
          rescue
            []
          catch
            kind, reason ->
              formatted_exception = Exception.format(kind, reason, System.stacktrace())
              Logger.error("Exception not defined in thrift spec was thrown: #{formatted_exception}")
              error = Thrift.TApplicationException.exception(type: :internal_error, message: "Server error: #{formatted_exception}")
              {:server_error, error}
          end
        {_, extra} ->
          raise(Thrift.TApplicationException, type: :protocol_error, message: "Could not decode #{inspect(extra)}")
      end
    end
    def(handle_thrift("emitZipkinBatch", binary_data, handler_module)) do
      case(Elixir.Jaeger.Thrift.Agent.EmitZipkinBatchArgs.BinaryProtocol.deserialize(binary_data)) do
        {%Jaeger.Thrift.Agent.EmitZipkinBatchArgs{spans: spans}, ""} ->
          try() do
            rsp = handler_module.emit_zipkin_batch(spans)
            (
              _ = rsp
              :noreply
            )
          rescue
            []
          catch
            kind, reason ->
              formatted_exception = Exception.format(kind, reason, System.stacktrace())
              Logger.error("Exception not defined in thrift spec was thrown: #{formatted_exception}")
              error = Thrift.TApplicationException.exception(type: :internal_error, message: "Server error: #{formatted_exception}")
              {:server_error, error}
          end
        {_, extra} ->
          raise(Thrift.TApplicationException, type: :protocol_error, message: "Could not decode #{inspect(extra)}")
      end
    end
  end
end