defmodule Frettchen.Run do

  def exec do
    trace = Frettchen.Trace.start("foo")
    span = Frettchen.Span.open(trace, "bar")
    span = Frettchen.Span.log(span, "foo", "bar")
    span = Frettchen.Span.tag(span, "foo", "bar")
    span = Frettchen.Span.close(span) 
  end
end
