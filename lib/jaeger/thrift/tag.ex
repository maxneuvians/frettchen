defmodule(Jaeger.Thrift.Tag) do
  _ = "Auto-generated Thrift struct jaeger.Tag"
  _ = "1: string key"
  _ = "2: jaeger.TagType v_type"
  _ = "3: string v_str"
  _ = "4: double v_double"
  _ = "5: bool v_bool"
  _ = "6: i64 v_long"
  _ = "7: binary v_binary"
  defstruct(key: nil, v_type: nil, v_str: nil, v_double: nil, v_bool: nil, v_long: nil, v_binary: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Jaeger.Thrift.Tag{})
    end
    defp(deserialize(<<0, rest::binary>>, %Jaeger.Thrift.Tag{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<11, 1::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | key: value})
    end
    defp(deserialize(<<8, 2::16-signed, value::32-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | v_type: value})
    end
    defp(deserialize(<<11, 3::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | v_str: value})
    end
    defp(deserialize(<<4, 4::16-signed, value::float-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | v_double: value})
    end
    defp(deserialize(<<2, 5::16-signed, 1, rest::binary>>, acc)) do
      deserialize(rest, %{acc | v_bool: true})
    end
    defp(deserialize(<<2, 5::16-signed, 0, rest::binary>>, acc)) do
      deserialize(rest, %{acc | v_bool: false})
    end
    defp(deserialize(<<10, 6::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | v_long: value})
    end
    defp(deserialize(<<11, 7::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | v_binary: value})
    end
    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end
    defp(deserialize(_, _)) do
      :error
    end
    def(serialize(%Jaeger.Thrift.Tag{key: key, v_type: v_type, v_str: v_str, v_double: v_double, v_bool: v_bool, v_long: v_long, v_binary: v_binary})) do
      [case(key) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :key on Jaeger.Thrift.Tag must not be nil")
        _ ->
          [<<11, 1::16-signed, byte_size(key)::32-signed>> | key]
      end, case(v_type) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :v_type on Jaeger.Thrift.Tag must not be nil")
        _ ->
          <<8, 2::16-signed, v_type::32-signed>>
      end, case(v_str) do
        nil ->
          <<>>
        _ ->
          [<<11, 3::16-signed, byte_size(v_str)::32-signed>> | v_str]
      end, case(v_double) do
        nil ->
          <<>>
        _ ->
          <<4, 4::16-signed, v_double::float-signed>>
      end, case(v_bool) do
        nil ->
          <<>>
        false ->
          <<2, 5::16-signed, 0>>
        true ->
          <<2, 5::16-signed, 1>>
        _ ->
          raise(Thrift.InvalidValueError, "Optional boolean field :v_bool on Jaeger.Thrift.Tag must be true, false, or nil")
      end, case(v_long) do
        nil ->
          <<>>
        _ ->
          <<10, 6::16-signed, v_long::64-signed>>
      end, case(v_binary) do
        nil ->
          <<>>
        _ ->
          [<<11, 7::16-signed, byte_size(v_binary)::32-signed>> | v_binary]
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