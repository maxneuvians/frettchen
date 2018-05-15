defmodule(Jaeger.Thrift.Process) do
  _ = "Auto-generated Thrift struct jaeger.Process"
  _ = "1: string service_name"
  _ = "2: list<jaeger.Tag> tags"
  defstruct(service_name: nil, tags: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Jaeger.Thrift.Process{})
    end
    defp(deserialize(<<0, rest::binary>>, %Jaeger.Thrift.Process{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<11, 1::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | service_name: value})
    end
    defp(deserialize(<<15, 2::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__tags(rest, [[], remaining, struct])
    end
    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end
    defp(deserialize(_, _)) do
      :error
    end
    defp(deserialize__tags(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | tags: Enum.reverse(list)})
    end
    defp(deserialize__tags(<<rest::binary>>, [list, remaining | stack])) do
      case(Elixir.Jaeger.Thrift.Tag.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__tags(rest, [[element | list], remaining - 1 | stack])
        :error ->
          :error
      end
    end
    defp(deserialize__tags(_, _)) do
      :error
    end
    def(serialize(%Jaeger.Thrift.Process{service_name: service_name, tags: tags})) do
      [case(service_name) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :service_name on Jaeger.Thrift.Process must not be nil")
        _ ->
          [<<11, 1::16-signed, byte_size(service_name)::32-signed>> | service_name]
      end, case(tags) do
        nil ->
          <<>>
        _ ->
          [<<15, 2::16-signed, 12, length(tags)::32-signed>> | for(e <- tags) do
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