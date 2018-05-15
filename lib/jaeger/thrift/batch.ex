defmodule(Jaeger.Thrift.Batch) do
  _ = "Auto-generated Thrift struct jaeger.Batch"
  _ = "1: jaeger.Process process"
  _ = "2: list<jaeger.Span> spans"
  defstruct(process: nil, spans: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Jaeger.Thrift.Batch{})
    end
    defp(deserialize(<<0, rest::binary>>, %Jaeger.Thrift.Batch{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
      case(Elixir.Jaeger.Thrift.Process.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | process: value})
        :error ->
          :error
      end
    end
    defp(deserialize(<<15, 2::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
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
      case(Elixir.Jaeger.Thrift.Span.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__spans(rest, [[element | list], remaining - 1 | stack])
        :error ->
          :error
      end
    end
    defp(deserialize__spans(_, _)) do
      :error
    end
    def(serialize(%Jaeger.Thrift.Batch{process: process, spans: spans})) do
      [case(process) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :process on Jaeger.Thrift.Batch must not be nil")
        _ ->
          [<<12, 1::16-signed>> | Jaeger.Thrift.Process.serialize(process)]
      end, case(spans) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :spans on Jaeger.Thrift.Batch must not be nil")
        _ ->
          [<<15, 2::16-signed, 12, length(spans)::32-signed>> | for(e <- spans) do
            Jaeger.Thrift.Span.serialize(e)
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