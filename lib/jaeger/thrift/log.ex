defmodule(Jaeger.Thrift.Log) do
  _ = "Auto-generated Thrift struct jaeger.Log"
  _ = "1: i64 timestamp"
  _ = "2: list<jaeger.Tag> fields"
  defstruct(timestamp: nil, fields: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Jaeger.Thrift.Log{})
    end
    defp(deserialize(<<0, rest::binary>>, %Jaeger.Thrift.Log{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<10, 1::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | timestamp: value})
    end
    defp(deserialize(<<15, 2::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__fields(rest, [[], remaining, struct])
    end
    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end
    defp(deserialize(_, _)) do
      :error
    end
    defp(deserialize__fields(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | fields: Enum.reverse(list)})
    end
    defp(deserialize__fields(<<rest::binary>>, [list, remaining | stack])) do
      case(Elixir.Jaeger.Thrift.Tag.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__fields(rest, [[element | list], remaining - 1 | stack])
        :error ->
          :error
      end
    end
    defp(deserialize__fields(_, _)) do
      :error
    end
    def(serialize(%Jaeger.Thrift.Log{timestamp: timestamp, fields: fields})) do
      [case(timestamp) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :timestamp on Jaeger.Thrift.Log must not be nil")
        _ ->
          <<10, 1::16-signed, timestamp::64-signed>>
      end, case(fields) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :fields on Jaeger.Thrift.Log must not be nil")
        _ ->
          [<<15, 2::16-signed, 12, length(fields)::32-signed>> | for(e <- fields) do
            Jaeger.Thrift.Tag.serialize(e)
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