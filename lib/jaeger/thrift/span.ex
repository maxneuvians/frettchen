defmodule(Jaeger.Thrift.Span) do
  _ = "Auto-generated Thrift struct jaeger.Span"
  _ = "1: i64 trace_id_low"
  _ = "2: i64 trace_id_high"
  _ = "3: i64 span_id"
  _ = "4: i64 parent_span_id"
  _ = "5: string operation_name"
  _ = "6: list<jaeger.SpanRef> references"
  _ = "7: i32 flags"
  _ = "8: i64 start_time"
  _ = "9: i64 duration"
  _ = "10: list<jaeger.Tag> tags"
  _ = "11: list<jaeger.Log> logs"
  defstruct(trace_id_low: nil, trace_id_high: nil, span_id: nil, parent_span_id: nil, operation_name: nil, references: nil, flags: nil, start_time: nil, duration: nil, tags: nil, logs: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Jaeger.Thrift.Span{})
    end
    defp(deserialize(<<0, rest::binary>>, %Jaeger.Thrift.Span{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<10, 1::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | trace_id_low: value})
    end
    defp(deserialize(<<10, 2::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | trace_id_high: value})
    end
    defp(deserialize(<<10, 3::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | span_id: value})
    end
    defp(deserialize(<<10, 4::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | parent_span_id: value})
    end
    defp(deserialize(<<11, 5::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | operation_name: value})
    end
    defp(deserialize(<<15, 6::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__references(rest, [[], remaining, struct])
    end
    defp(deserialize(<<8, 7::16-signed, value::32-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | flags: value})
    end
    defp(deserialize(<<10, 8::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | start_time: value})
    end
    defp(deserialize(<<10, 9::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | duration: value})
    end
    defp(deserialize(<<15, 10::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__tags(rest, [[], remaining, struct])
    end
    defp(deserialize(<<15, 11::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__logs(rest, [[], remaining, struct])
    end
    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end
    defp(deserialize(_, _)) do
      :error
    end
    defp(deserialize__logs(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | logs: Enum.reverse(list)})
    end
    defp(deserialize__logs(<<rest::binary>>, [list, remaining | stack])) do
      case(Elixir.Jaeger.Thrift.Log.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__logs(rest, [[element | list], remaining - 1 | stack])
        :error ->
          :error
      end
    end
    defp(deserialize__logs(_, _)) do
      :error
    end
    defp(deserialize__references(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | references: Enum.reverse(list)})
    end
    defp(deserialize__references(<<rest::binary>>, [list, remaining | stack])) do
      case(Elixir.Jaeger.Thrift.SpanRef.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__references(rest, [[element | list], remaining - 1 | stack])
        :error ->
          :error
      end
    end
    defp(deserialize__references(_, _)) do
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
    def(serialize(%Jaeger.Thrift.Span{trace_id_low: trace_id_low, trace_id_high: trace_id_high, span_id: span_id, parent_span_id: parent_span_id, operation_name: operation_name, references: references, flags: flags, start_time: start_time, duration: duration, tags: tags, logs: logs})) do
      [case(trace_id_low) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :trace_id_low on Jaeger.Thrift.Span must not be nil")
        _ ->
          <<10, 1::16-signed, trace_id_low::64-signed>>
      end, case(trace_id_high) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :trace_id_high on Jaeger.Thrift.Span must not be nil")
        _ ->
          <<10, 2::16-signed, trace_id_high::64-signed>>
      end, case(span_id) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :span_id on Jaeger.Thrift.Span must not be nil")
        _ ->
          <<10, 3::16-signed, span_id::64-signed>>
      end, case(parent_span_id) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :parent_span_id on Jaeger.Thrift.Span must not be nil")
        _ ->
          <<10, 4::16-signed, parent_span_id::64-signed>>
      end, case(operation_name) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :operation_name on Jaeger.Thrift.Span must not be nil")
        _ ->
          [<<11, 5::16-signed, byte_size(operation_name)::32-signed>> | operation_name]
      end, case(references) do
        nil ->
          <<>>
        _ ->
          [<<15, 6::16-signed, 12, length(references)::32-signed>> | for(e <- references) do
            Jaeger.Thrift.SpanRef.serialize(e)
          end]
      end, case(flags) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :flags on Jaeger.Thrift.Span must not be nil")
        _ ->
          <<8, 7::16-signed, flags::32-signed>>
      end, case(start_time) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :start_time on Jaeger.Thrift.Span must not be nil")
        _ ->
          <<10, 8::16-signed, start_time::64-signed>>
      end, case(duration) do
        nil ->
          raise(Thrift.InvalidValueError, "Required field :duration on Jaeger.Thrift.Span must not be nil")
        _ ->
          <<10, 9::16-signed, duration::64-signed>>
      end, case(tags) do
        nil ->
          <<>>
        _ ->
          [<<15, 10::16-signed, 12, length(tags)::32-signed>> | for(e <- tags) do
            Jaeger.Thrift.Tag.serialize(e)
          end]
      end, case(logs) do
        nil ->
          <<>>
        _ ->
          [<<15, 11::16-signed, 12, length(logs)::32-signed>> | for(e <- logs) do
            Jaeger.Thrift.Log.serialize(e)
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