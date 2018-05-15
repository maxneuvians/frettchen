defmodule(Jaeger.Thrift.Agent.Handler) do
  @callback(emit_batch(batch :: %Jaeger.Thrift.Batch{}) :: no_return())
  @callback(emit_zipkin_batch(spans :: [%Jaeger.Thrift.Agent.Zipkin.Span{}]) :: no_return())
end