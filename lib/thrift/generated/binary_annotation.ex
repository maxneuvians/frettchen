defmodule(Thrift.Generated.BinaryAnnotation) do
  _ = "Auto-generated Thrift struct zipkincore.BinaryAnnotation"
  _ = "1: string key"
  _ = "2: binary value"
  _ = "3: zipkincore.AnnotationType annotation_type"
  _ = "4: zipkincore.Endpoint host"
  defstruct(key: nil, value: nil, annotation_type: nil, host: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.BinaryAnnotation{})
    end
    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.BinaryAnnotation{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<11, 1::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | key: value})
    end
    defp(deserialize(<<11, 2::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | value: value})
    end
    defp(deserialize(<<8, 3::16-signed, value::32-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | annotation_type: value})
    end
    defp(deserialize(<<12, 4::16-signed, rest::binary>>, acc)) do
      case(Elixir.Thrift.Generated.Endpoint.BinaryProtocol.deserialize(rest)) do
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
    def(serialize(%Thrift.Generated.BinaryAnnotation{key: key, value: value, annotation_type: annotation_type, host: host})) do
      [case(key) do
        nil ->
          <<>>
        _ ->
          [<<11, 1::16-signed, byte_size(key)::32-signed>> | key]
      end, case(value) do
        nil ->
          <<>>
        _ ->
          [<<11, 2::16-signed, byte_size(value)::32-signed>> | value]
      end, case(annotation_type) do
        nil ->
          <<>>
        _ ->
          <<8, 3::16-signed, annotation_type::32-signed>>
      end, case(host) do
        nil ->
          <<>>
        _ ->
          [<<12, 4::16-signed>> | Thrift.Generated.Endpoint.serialize(host)]
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