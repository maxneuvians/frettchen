defmodule(Thrift.Generated.ZipkinCollector.Handler) do
  @callback(submit_zipkin_batch(spans :: [%Thrift.Generated.Span{}]) :: [%Thrift.Generated.Response{}])
end