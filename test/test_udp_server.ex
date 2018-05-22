defmodule Frettchen.TestUdpServer do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok)
  end

  @impl true
  def init(state) do
    Socket.UDP.open!(32_409)
    {:ok, state}
  end
end
