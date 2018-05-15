defmodule(Jaeger.Thrift.Agent.Handler) do
  @callback(emit_batch(batch :: %Jaeger.Thrift.Batch{}) :: no_return())
  @callback(emit_zipkin_batch(spans :: [%Thrift.Generated.Span{}]) :: no_return())
end