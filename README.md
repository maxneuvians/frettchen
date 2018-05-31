# Frettchen

Frettchen (German for Ferret) is a pure elixir client library for tracing in distributed microservices using the Jaeger backend. It is still in development and not recommended for production for two reasons:

1. It has a dependency on elixir-thrift 2.0 (https://github.com/pinterest/elixir-thrift) which is not yet available on hex.

2. It currently samples 100% of your traces. This is not a desirable feature for production systems.

## Architecture
Assuming familiarity with Jaeger, every `Trace` is a process. A `Span` is a struct that is part of a map inside a `Trace` process. Interacting with a `Span` is done throught the `Frettchen.Span` module. A complete example looks like this.

```elixir
def simple_trace() do
    span = Trace.start("foo")
    |> Span.open("bar")

    (.. do some stuff)

    span
    |> Span.close()
  end
```

Each `Trace` has it's own configuration about where to report spans. They can either be sent via UDP to the Jaeger Agent or TCP to the Jaeger Collector. They can also be reported to a `Null` Reporter or a `Logging` Reporter. Please review `Frettchen.Configuration` for configuration options. A `Trace` also has a time out that will close any open `Span`'s which ensures that there are no dangling `Span`s.

Once a `Span` is closed it gets sent to a `Collector` Producer that then dispatches it to a reporter. If the reporter is the `Remote` reporter it invokes a ConsumerSupervisor that then creates a new process to send the data to Jaeger. This way traffic can be shaped before it gets sent to Jaeger.

## Installation

```elixir
def deps do
  [{:frettchen, github: "maxneuvians/frettchen"}]
end
```

## License
MIT
