defmodule(Jaeger.Thrift.Collector.Handler) do
  @callback(submit_batches(batches :: [%Jaeger.Thrift.Batch{}]) :: [%Jaeger.Thrift.BatchSubmitResponse{}])
end