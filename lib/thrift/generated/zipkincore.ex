defmodule(Thrift.Generated.Zipkincore) do
  defmacro(client_addr) do
    Macro.escape("ca")
  end
  defmacro(client_recv) do
    Macro.escape("cr")
  end
  defmacro(client_recv_fragment) do
    Macro.escape("crf")
  end
  defmacro(client_send) do
    Macro.escape("cs")
  end
  defmacro(client_send_fragment) do
    Macro.escape("csf")
  end
  defmacro(local_component) do
    Macro.escape("lc")
  end
  defmacro(message_addr) do
    Macro.escape("ma")
  end
  defmacro(message_recv) do
    Macro.escape("mr")
  end
  defmacro(message_send) do
    Macro.escape("ms")
  end
  defmacro(server_addr) do
    Macro.escape("sa")
  end
  defmacro(server_recv) do
    Macro.escape("sr")
  end
  defmacro(server_recv_fragment) do
    Macro.escape("srf")
  end
  defmacro(server_send) do
    Macro.escape("ss")
  end
  defmacro(server_send_fragment) do
    Macro.escape("ssf")
  end
  defmacro(wire_recv) do
    Macro.escape("wr")
  end
  defmacro(wire_send) do
    Macro.escape("ws")
  end
end