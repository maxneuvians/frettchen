defmodule Frettchen.Helpers do
  @moduledoc """
  A collection of helper functions
  """

  @doc """
  Returns the current timestamp as 
  an integer

  ## Example
    iex> timestamp = Frettchen.Helpers.current_time()
    ...> is_integer(timestamp)
    true
  """
  def current_time do
    {p1, p2, p3} = :os.timestamp()
    "#{p1}#{p2}#{p3}"
    |> Integer.parse
    |> elem(0)
  end

  @doc """
  Formats the name of a span to a string

  ## Examples
    iex> Frettchen.Helpers.format_name("foo")
    "foo"

    iex> Frettchen.Helpers.format_name(:foo)
    "foo"

    iex> Frettchen.Helpers.format_name(3.14)
    "Illegal operation name: 3.14"
  """
  def format_name(name) when is_binary(name), do: name
  def format_name(name) when is_atom(name), do: Atom.to_string(name)
  def format_name(name), do: "Illegal operation name: #{name}"
  
  @doc """
  Generates a random 64 bit integer

  ## Example
    iex> id = Frettchen.Helpers.random_id()
    ...> is_integer(id)
    true
  """
  def random_id do
    <<id::64>> = :crypto.strong_rand_bytes(8)
    id
  end
end
