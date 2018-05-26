defmodule Frettchen.TestUdpServer do
  @moduledoc """
  A test UDP server for receiving UDP packages
  sent to the Agent. The corresponding tests
  check if the process recieved a UDP call.
  """
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(_state) do
    server = Socket.UDP.open!(32_409)
    start_listening()
    {:ok, server}
  end

  @impl true
  def handle_info(:data_recieved, server) do
    {:noreply, server}
  end

  @impl true
  def handle_info(:start_listening, server) do
    server |> Socket.Datagram.recv!
    Process.send(self(), :data_recieved, [])
    {:noreply, server}
  end 

  defp start_listening() do
    Process.send(self(), :start_listening, [])
  end
end
