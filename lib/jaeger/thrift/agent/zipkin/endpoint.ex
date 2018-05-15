defmodule(Jaeger.Thrift.Agent.Zipkin.Endpoint) do
  _ = "Auto-generated Thrift struct zipkincore.Endpoint"
  _ = "1: i32 ipv4"
  _ = "2: i16 port"
  _ = "3: string service_name"
  _ = "4: binary ipv6"
  defstruct(ipv4: nil, port: nil, service_name: nil, ipv6: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Jaeger.Thrift.Agent.Zipkin.Endpoint{})
    end
    defp(deserialize(<<0, rest::binary>>, %Jaeger.Thrift.Agent.Zipkin.Endpoint{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<8, 1::16-signed, value::32-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | ipv4: value})
    end
    defp(deserialize(<<6, 2::16-signed, value::16-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | port: value})
    end
    defp(deserialize(<<11, 3::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | service_name: value})
    end
    defp(deserialize(<<11, 4::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | ipv6: value})
    end
    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end
    defp(deserialize(_, _)) do
      :error
    end
    def(serialize(%Jaeger.Thrift.Agent.Zipkin.Endpoint{ipv4: ipv4, port: port, service_name: service_name, ipv6: ipv6})) do
      [case(ipv4) do
        nil ->
          <<>>
        _ ->
          <<8, 1::16-signed, ipv4::32-signed>>
      end, case(port) do
        nil ->
          <<>>
        _ ->
          <<6, 2::16-signed, port::16-signed>>
      end, case(service_name) do
        nil ->
          <<>>
        _ ->
          [<<11, 3::16-signed, byte_size(service_name)::32-signed>> | service_name]
      end, case(ipv6) do
        nil ->
          <<>>
        _ ->
          [<<11, 4::16-signed, byte_size(ipv6)::32-signed>> | ipv6]
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