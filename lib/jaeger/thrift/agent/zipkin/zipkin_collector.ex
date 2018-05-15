defmodule(Jaeger.Thrift.Agent.Zipkin.ZipkinCollector) do
  defmodule(SubmitZipkinBatchArgs) do
    _ = "Auto-generated Thrift struct Elixir.SubmitZipkinBatchArgs"
    _ = "1: list<zipkincore.Span> spans"
    defstruct(spans: nil)
    @type(t :: %__MODULE__{})
    def(new) do
      %__MODULE__{}
    end
    defmodule(BinaryProtocol) do
      @moduledoc(false)
      def(deserialize(binary)) do
        deserialize(binary, %SubmitZipkinBatchArgs{})
      end
      defp(deserialize(<<0, rest::binary>>, %SubmitZipkinBatchArgs{} = acc)) do
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
      def(serialize(%SubmitZipkinBatchArgs{spans: spans})) do
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
  defmodule(SubmitZipkinBatchResponse) do
    _ = "Auto-generated Thrift struct Elixir.SubmitZipkinBatchResponse"
    _ = "0: list<zipkincore.Response> success"
    defstruct(success: nil)
    @type(t :: %__MODULE__{})
    def(new) do
      %__MODULE__{}
    end
    defmodule(BinaryProtocol) do
      @moduledoc(false)
      def(deserialize(binary)) do
        deserialize(binary, %SubmitZipkinBatchResponse{})
      end
      defp(deserialize(<<0, rest::binary>>, %SubmitZipkinBatchResponse{} = acc)) do
        {acc, rest}
      end
      defp(deserialize(<<15, 0::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
        deserialize__success(rest, [[], remaining, struct])
      end
      defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
        rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
      end
      defp(deserialize(_, _)) do
        :error
      end
      defp(deserialize__success(<<rest::binary>>, [list, 0, struct])) do
        deserialize(rest, %{struct | success: Enum.reverse(list)})
      end
      defp(deserialize__success(<<rest::binary>>, [list, remaining | stack])) do
        case(Elixir.Jaeger.Thrift.Agent.Zipkin.Response.BinaryProtocol.deserialize(rest)) do
          {element, rest} ->
            deserialize__success(rest, [[element | list], remaining - 1 | stack])
          :error ->
            :error
        end
      end
      defp(deserialize__success(_, _)) do
        :error
      end
      def(serialize(%SubmitZipkinBatchResponse{success: success})) do
        [case(success) do
          nil ->
            <<>>
          _ ->
            [<<15, 0::16-signed, 12, length(success)::32-signed>> | for(e <- success) do
              Jaeger.Thrift.Agent.Zipkin.Response.serialize(e)
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
    def(unquote(:submit_zipkin_batch)(client, spans, rpc_opts \\ [])) do
      args = %SubmitZipkinBatchArgs{spans: spans}
      serialized_args = SubmitZipkinBatchArgs.BinaryProtocol.serialize(args)
      ClientImpl.call(client, "submitZipkinBatch", serialized_args, SubmitZipkinBatchResponse.BinaryProtocol, rpc_opts)
    end
    def(unquote(:submit_zipkin_batch!)(client, spans, rpc_opts \\ [])) do
      case(unquote(:submit_zipkin_batch)(client, spans, rpc_opts)) do
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
    def(handle_thrift("submitZipkinBatch", binary_data, handler_module)) do
      case(Elixir.Jaeger.Thrift.Agent.Zipkin.ZipkinCollector.SubmitZipkinBatchArgs.BinaryProtocol.deserialize(binary_data)) do
        {%Jaeger.Thrift.Agent.Zipkin.ZipkinCollector.SubmitZipkinBatchArgs{spans: spans}, ""} ->
          try() do
            rsp = handler_module.submit_zipkin_batch(spans)
            (
              response = %Jaeger.Thrift.Agent.Zipkin.ZipkinCollector.SubmitZipkinBatchResponse{success: rsp}
              {:reply, Elixir.Jaeger.Thrift.Agent.Zipkin.ZipkinCollector.SubmitZipkinBatchResponse.BinaryProtocol.serialize(response)}
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