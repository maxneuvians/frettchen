defmodule(Jaeger.Thrift.TagType) do
  @moduledoc("Auto-generated Thrift enum jaeger.TagType")
  defmacro(unquote(:string)()) do
    0
  end
  defmacro(unquote(:double)()) do
    1
  end
  defmacro(unquote(:bool)()) do
    2
  end
  defmacro(unquote(:long)()) do
    3
  end
  defmacro(unquote(:binary)()) do
    4
  end
  def(value_to_name(0)) do
    {:ok, :string}
  end
  def(value_to_name(1)) do
    {:ok, :double}
  end
  def(value_to_name(2)) do
    {:ok, :bool}
  end
  def(value_to_name(3)) do
    {:ok, :long}
  end
  def(value_to_name(4)) do
    {:ok, :binary}
  end
  def(value_to_name(v)) do
    {:error, {:invalid_enum_value, v}}
  end
  def(name_to_value(:string)) do
    {:ok, 0}
  end
  def(name_to_value(:double)) do
    {:ok, 1}
  end
  def(name_to_value(:bool)) do
    {:ok, 2}
  end
  def(name_to_value(:long)) do
    {:ok, 3}
  end
  def(name_to_value(:binary)) do
    {:ok, 4}
  end
  def(name_to_value(k)) do
    {:error, {:invalid_enum_name, k}}
  end
  def(value_to_name!(value)) do
    {:ok, name} = value_to_name(value)
    name
  end
  def(name_to_value!(name)) do
    {:ok, value} = name_to_value(name)
    value
  end
  def(meta(:names)) do
    [:string, :double, :bool, :long, :binary]
  end
  def(meta(:values)) do
    [0, 1, 2, 3, 4]
  end
  def(member?(0)) do
    true
  end
  def(member?(1)) do
    true
  end
  def(member?(2)) do
    true
  end
  def(member?(3)) do
    true
  end
  def(member?(4)) do
    true
  end
  def(member?(_)) do
    false
  end
  def(name?(:string)) do
    true
  end
  def(name?(:double)) do
    true
  end
  def(name?(:bool)) do
    true
  end
  def(name?(:long)) do
    true
  end
  def(name?(:binary)) do
    true
  end
  def(name?(_)) do
    false
  end
end