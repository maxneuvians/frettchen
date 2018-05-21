defmodule Frettchen.Reporter.Sender do
  def start_link(event) do
    Task.start_link(fn -> 
      IO.inspect({self(), event})
    end)
  end
end
