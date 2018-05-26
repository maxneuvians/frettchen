defmodule Frettchen.TestTcpServer do
  @moduledoc """
  A test TCP server to receive the payload
  send by the Sender to the Collector. The 
  correpsonding tests check if this process
  has called a recieving data action.
  """
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(_state) do
    server = Socket.TCP.listen!(32_509, packet: :line)
    start_listening()
    {:ok, server}
  end

  @impl true
  def handle_info(:data_recieved, server) do
    {:noreply, server}
  end

  @impl true
  def handle_info(:start_listening, server) do
    server 
      |> Socket.accept!
    Process.send(self(), :data_recieved, [])
    {:noreply, server}
  end 

  defp start_listening() do
    Process.send(self(), :start_listening, [])
  end
end
