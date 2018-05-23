defmodule Frettchen.Run do

  def exec do
    configuration = %{ %Frettchen.Configuration{} | target: :collector}
    trace = Frettchen.Trace.start("fiz", [configuration: configuration])
    span = Frettchen.Span.open(trace, "bar")
    span = Frettchen.Span.log(span, "foo", "bar")
    span = Frettchen.Span.tag(span, "foo", "bar")
    span = Frettchen.Span.close(span) 
  end
end
