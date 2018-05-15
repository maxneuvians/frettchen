defmodule(Jaeger.Thrift.Agent.Zipkin.Response) do
  _ = "Auto-generated Thrift struct zipkincore.Response"
  _ = "1: bool ok"
  defstruct(ok: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Jaeger.Thrift.Agent.Zipkin.Response{})
    end
    defp(deserialize(<<0, rest::binary>>, %Jaeger.Thrift.Agent.Zipkin.Response{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<2, 1::16-signed, 1, rest::binary>>, acc)) do
      deserialize(rest, %{acc | ok: true})
    end
    defp(deserialize(<<2, 1::16-signed, 0, rest::binary>>, acc)) do
      deserialize(rest, %{acc | ok: false})
    end
    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end
    defp(deserialize(_, _)) do
      :error
    end
    def(serialize(%Jaeger.Thrift.Agent.Zipkin.Response{ok: ok})) do
      [case(ok) do
        false ->
          <<2, 1::16-signed, 0>>
        true ->
          <<2, 1::16-signed, 1>>
        _ ->
          raise(Thrift.InvalidValueError, "Required boolean field :ok on Jaeger.Thrift.Agent.Zipkin.Response must be true or false")
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