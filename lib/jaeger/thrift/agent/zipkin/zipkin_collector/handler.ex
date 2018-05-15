defmodule(Jaeger.Thrift.Agent.Zipkin.ZipkinCollector.Handler) do
  @callback(submit_zipkin_batch(spans :: [%Jaeger.Thrift.Agent.Zipkin.Span{}]) :: [%Jaeger.Thrift.Agent.Zipkin.Response{}])
end