defmodule(Jaeger.Thrift.Collector) do
  defmodule(SubmitBatchesArgs) do
    _ = "Auto-generated Thrift struct Elixir.SubmitBatchesArgs"
    _ = "1: list<jaeger.Batch> batches"
    defstruct(batches: nil)
    @type(t :: %__MODULE__{})
    def(new) do
      %__MODULE__{}
    end
    defmodule(BinaryProtocol) do
      @moduledoc(false)
      def(deserialize(binary)) do
        deserialize(binary, %SubmitBatchesArgs{})
      end
      defp(deserialize(<<0, rest::binary>>, %SubmitBatchesArgs{} = acc)) do
        {acc, rest}
      end
      defp(deserialize(<<15, 1::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
        deserialize__batches(rest, [[], remaining, struct])
      end
      defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
        rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
      end
      defp(deserialize(_, _)) do
        :error
      end
      defp(deserialize__batches(<<rest::binary>>, [list, 0, struct])) do
        deserialize(rest, %{struct | batches: Enum.reverse(list)})
      end
      defp(deserialize__batches(<<rest::binary>>, [list, remaining | stack])) do
        case(Elixir.Jaeger.Thrift.Batch.BinaryProtocol.deserialize(rest)) do
          {element, rest} ->
            deserialize__batches(rest, [[element | list], remaining - 1 | stack])
          :error ->
            :error
        end
      end
      defp(deserialize__batches(_, _)) do
        :error
      end
      def(serialize(%SubmitBatchesArgs{batches: batches})) do
        [case(batches) do
          nil ->
            <<>>
          _ ->
            [<<15, 1::16-signed, 12, length(batches)::32-signed>> | for(e <- batches) do
              Jaeger.Thrift.Batch.serialize(e)
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
  defmodule(SubmitBatchesResponse) do
    _ = "Auto-generated Thrift struct Elixir.SubmitBatchesResponse"
    _ = "0: list<jaeger.BatchSubmitResponse> success"
    defstruct(success: nil)
    @type(t :: %__MODULE__{})
    def(new) do
      %__MODULE__{}
    end
    defmodule(BinaryProtocol) do
      @moduledoc(false)
      def(deserialize(binary)) do
        deserialize(binary, %SubmitBatchesResponse{})
      end
      defp(deserialize(<<0, rest::binary>>, %SubmitBatchesResponse{} = acc)) do
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
        case(Elixir.Jaeger.Thrift.BatchSubmitResponse.BinaryProtocol.deserialize(rest)) do
          {element, rest} ->
            deserialize__success(rest, [[element | list], remaining - 1 | stack])
          :error ->
            :error
        end
      end
      defp(deserialize__success(_, _)) do
        :error
      end
      def(serialize(%SubmitBatchesResponse{success: success})) do
        [case(success) do
          nil ->
            <<>>
          _ ->
            [<<15, 0::16-signed, 12, length(success)::32-signed>> | for(e <- success) do
              Jaeger.Thrift.BatchSubmitResponse.serialize(e)
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
    def(unquote(:submit_batches)(client, batches, rpc_opts \\ [])) do
      args = %SubmitBatchesArgs{batches: batches}
      serialized_args = SubmitBatchesArgs.BinaryProtocol.serialize(args)
      ClientImpl.call(client, "submitBatches", serialized_args, SubmitBatchesResponse.BinaryProtocol, rpc_opts)
    end
    def(unquote(:submit_batches!)(client, batches, rpc_opts \\ [])) do
      case(unquote(:submit_batches)(client, batches, rpc_opts)) do
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
    def(handle_thrift("submitBatches", binary_data, handler_module)) do
      case(Elixir.Jaeger.Thrift.Collector.SubmitBatchesArgs.BinaryProtocol.deserialize(binary_data)) do
        {%Jaeger.Thrift.Collector.SubmitBatchesArgs{batches: batches}, ""} ->
          try() do
            rsp = handler_module.submit_batches(batches)
            (
              response = %Jaeger.Thrift.Collector.SubmitBatchesResponse{success: rsp}
              {:reply, Elixir.Jaeger.Thrift.Collector.SubmitBatchesResponse.BinaryProtocol.serialize(response)}
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