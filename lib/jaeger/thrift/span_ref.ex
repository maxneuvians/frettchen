defmodule(Jaeger.Thrift.SpanRef) do
  _ = "Auto-generated Thrift struct jaeger.SpanRef"
  _ = "1: jaeger.SpanRefType ref_type"
  _ = "2: i64 trace_id_low"
  _ = "3: i64 trace_id_high"
  _ = "4: i64 span_id"
  defstruct(ref_type: nil, trace_id_low: nil, trace_id_high: nil, span_id: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Jaeger.Thrift.SpanRef{})
    end
    defp(deserialize(<<0, rest::binary>>, %Jaeger.Thrift.SpanRef{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<8, 1::16-signed, value::32-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | ref_type: value})
    end
    defp(deserialize(<<10, 2::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | trace_id_low: value})
    end
    defp(deserialize(<<10, 3::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | trace_id_high: value})
    end
    defp(deserialize(<<10, 4::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | span_id: value})
    end
    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end
    defp(deserialize(_, _)) do
      :error
    end
    def(serialize(%Jaeger.Thrift.SpanRef{ref_type: ref_type, trace_id_low: trace_id_low, trace_id_high: trace_id_high, span_id: span_id})) do
      [case(ref_type) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :ref_type on Jaeger.Thrift.SpanRef must not be nil")
        _ ->
          <<8, 1::16-signed, ref_type::32-signed>>
      end, case(trace_id_low) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :trace_id_low on Jaeger.Thrift.SpanRef must not be nil")
        _ ->
          <<10, 2::16-signed, trace_id_low::64-signed>>
      end, case(trace_id_high) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :trace_id_high on Jaeger.Thrift.SpanRef must not be nil")
        _ ->
          <<10, 3::16-signed, trace_id_high::64-signed>>
      end, case(span_id) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :span_id on Jaeger.Thrift.SpanRef must not be nil")
        _ ->
          <<10, 4::16-signed, span_id::64-signed>>
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