defmodule(Jaeger.Thrift.Agent.Zipkin.Annotation) do
  _ = "Auto-generated Thrift struct zipkincore.Annotation"
  _ = "1: i64 timestamp"
  _ = "2: string value"
  _ = "3: zipkincore.Endpoint host"
  defstruct(timestamp: nil, value: nil, host: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Jaeger.Thrift.Agent.Zipkin.Annotation{})
    end
    defp(deserialize(<<0, rest::binary>>, %Jaeger.Thrift.Agent.Zipkin.Annotation{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<10, 1::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | timestamp: value})
    end
    defp(deserialize(<<11, 2::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | value: value})
    end
    defp(deserialize(<<12, 3::16-signed, rest::binary>>, acc)) do
      case(Elixir.Jaeger.Thrift.Agent.Zipkin.Endpoint.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | host: value})
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
    def(serialize(%Jaeger.Thrift.Agent.Zipkin.Annotation{timestamp: timestamp, value: value, host: host})) do
      [case(timestamp) do
        nil ->
          <<>>
        _ ->
          <<10, 1::16-signed, timestamp::64-signed>>
      end, case(value) do
        nil ->
          <<>>
        _ ->
          [<<11, 2::16-signed, byte_size(value)::32-signed>> | value]
      end, case(host) do
        nil ->
          <<>>
        _ ->
          [<<12, 3::16-signed>> | Jaeger.Thrift.Agent.Zipkin.Endpoint.serialize(host)]
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