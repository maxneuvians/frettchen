defmodule(Jaeger.Thrift.SpanRefType) do
  @moduledoc("Auto-generated Thrift enum jaeger.SpanRefType")
  defmacro(unquote(:child_of)()) do
    0
  end
  defmacro(unquote(:follows_from)()) do
    1
  end
  def(value_to_name(0)) do
    {:ok, :child_of}
  end
  def(value_to_name(1)) do
    {:ok, :follows_from}
  end
  def(value_to_name(v)) do
    {:error, {:invalid_enum_value, v}}
  end
  def(name_to_value(:child_of)) do
    {:ok, 0}
  end
  def(name_to_value(:follows_from)) do
    {:ok, 1}
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
    [:child_of, :follows_from]
  end
  def(meta(:values)) do
    [0, 1]
  end
  def(member?(0)) do
    true
  end
  def(member?(1)) do
    true
  end
  def(member?(_)) do
    false
  end
  def(name?(:child_of)) do
    true
  end
  def(name?(:follows_from)) do
    true
  end
  def(name?(_)) do
    false
  end
end