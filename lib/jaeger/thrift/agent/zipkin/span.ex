defmodule(Jaeger.Thrift.Agent.Zipkin.Span) do
  _ = "Auto-generated Thrift struct zipkincore.Span"
  _ = "1: i64 trace_id"
  _ = "3: string name"
  _ = "4: i64 id"
  _ = "5: i64 parent_id"
  _ = "6: list<zipkincore.Annotation> annotations"
  _ = "8: list<zipkincore.BinaryAnnotation> binary_annotations"
  _ = "9: bool debug"
  _ = "10: i64 timestamp"
  _ = "11: i64 duration"
  _ = "12: i64 trace_id_high"
  defstruct(trace_id: nil, name: nil, id: nil, parent_id: nil, annotations: nil, binary_annotations: nil, debug: false, timestamp: nil, duration: nil, trace_id_high: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Jaeger.Thrift.Agent.Zipkin.Span{})
    end
    defp(deserialize(<<0, rest::binary>>, %Jaeger.Thrift.Agent.Zipkin.Span{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<10, 1::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | trace_id: value})
    end
    defp(deserialize(<<11, 3::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | name: value})
    end
    defp(deserialize(<<10, 4::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | id: value})
    end
    defp(deserialize(<<10, 5::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | parent_id: value})
    end
    defp(deserialize(<<15, 6::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__annotations(rest, [[], remaining, struct])
    end
    defp(deserialize(<<15, 8::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__binary_annotations(rest, [[], remaining, struct])
    end
    defp(deserialize(<<2, 9::16-signed, 1, rest::binary>>, acc)) do
      deserialize(rest, %{acc | debug: true})
    end
    defp(deserialize(<<2, 9::16-signed, 0, rest::binary>>, acc)) do
      deserialize(rest, %{acc | debug: false})
    end
    defp(deserialize(<<10, 10::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | timestamp: value})
    end
    defp(deserialize(<<10, 11::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | duration: value})
    end
    defp(deserialize(<<10, 12::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | trace_id_high: value})
    end
    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end
    defp(deserialize(_, _)) do
      :error
    end
    defp(deserialize__annotations(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | annotations: Enum.reverse(list)})
    end
    defp(deserialize__annotations(<<rest::binary>>, [list, remaining | stack])) do
      case(Elixir.Jaeger.Thrift.Agent.Zipkin.Annotation.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__annotations(rest, [[element | list], remaining - 1 | stack])
        :error ->
          :error
      end
    end
    defp(deserialize__annotations(_, _)) do
      :error
    end
    defp(deserialize__binary_annotations(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | binary_annotations: Enum.reverse(list)})
    end
    defp(deserialize__binary_annotations(<<rest::binary>>, [list, remaining | stack])) do
      case(Elixir.Jaeger.Thrift.Agent.Zipkin.BinaryAnnotation.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__binary_annotations(rest, [[element | list], remaining - 1 | stack])
        :error ->
          :error
      end
    end
    defp(deserialize__binary_annotations(_, _)) do
      :error
    end
    def(serialize(%Jaeger.Thrift.Agent.Zipkin.Span{trace_id: trace_id, name: name, id: id, parent_id: parent_id, annotations: annotations, binary_annotations: binary_annotations, debug: debug, timestamp: timestamp, duration: duration, trace_id_high: trace_id_high})) do
      [case(trace_id) do
        nil ->
          <<>>
        _ ->
          <<10, 1::16-signed, trace_id::64-signed>>
      end, case(name) do
        nil ->
          <<>>
        _ ->
          [<<11, 3::16-signed, byte_size(name)::32-signed>> | name]
      end, case(id) do
        nil ->
          <<>>
        _ ->
          <<10, 4::16-signed, id::64-signed>>
      end, case(parent_id) do
        nil ->
          <<>>
        _ ->
          <<10, 5::16-signed, parent_id::64-signed>>
      end, case(annotations) do
        nil ->
          <<>>
        _ ->
          [<<15, 6::16-signed, 12, length(annotations)::32-signed>> | for(e <- annotations) do
            Jaeger.Thrift.Agent.Zipkin.Annotation.serialize(e)
          end]
      end, case(binary_annotations) do
        nil ->
          <<>>
        _ ->
          [<<15, 8::16-signed, 12, length(binary_annotations)::32-signed>> | for(e <- binary_annotations) do
            Jaeger.Thrift.Agent.Zipkin.BinaryAnnotation.serialize(e)
          end]
      end, case(debug) do
        nil ->
          <<>>
        false ->
          <<2, 9::16-signed, 0>>
        true ->
          <<2, 9::16-signed, 1>>
        _ ->
          raise(Thrift.InvalidValueError, "Optional boolean field :debug on Jaeger.Thrift.Agent.Zipkin.Span must be true, false, or nil")
      end, case(timestamp) do
        nil ->
          <<>>
        _ ->
          <<10, 10::16-signed, timestamp::64-signed>>
      end, case(duration) do
        nil ->
          <<>>
        _ ->
          <<10, 11::16-signed, duration::64-signed>>
      end, case(trace_id_high) do
        nil ->
          <<>>
        _ ->
          <<10, 12::16-signed, trace_id_high::64-signed>>
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