defmodule(Jaeger.Thrift.Agent.Zipkin.AnnotationType) do
  @moduledoc("Auto-generated Thrift enum zipkincore.AnnotationType")
  defmacro(unquote(:bool)()) do
    0
  end
  defmacro(unquote(:bytes)()) do
    1
  end
  defmacro(unquote(:i16)()) do
    2
  end
  defmacro(unquote(:i32)()) do
    3
  end
  defmacro(unquote(:i64)()) do
    4
  end
  defmacro(unquote(:double)()) do
    5
  end
  defmacro(unquote(:string)()) do
    6
  end
  def(value_to_name(0)) do
    {:ok, :bool}
  end
  def(value_to_name(1)) do
    {:ok, :bytes}
  end
  def(value_to_name(2)) do
    {:ok, :i16}
  end
  def(value_to_name(3)) do
    {:ok, :i32}
  end
  def(value_to_name(4)) do
    {:ok, :i64}
  end
  def(value_to_name(5)) do
    {:ok, :double}
  end
  def(value_to_name(6)) do
    {:ok, :string}
  end
  def(value_to_name(v)) do
    {:error, {:invalid_enum_value, v}}
  end
  def(name_to_value(:bool)) do
    {:ok, 0}
  end
  def(name_to_value(:bytes)) do
    {:ok, 1}
  end
  def(name_to_value(:i16)) do
    {:ok, 2}
  end
  def(name_to_value(:i32)) do
    {:ok, 3}
  end
  def(name_to_value(:i64)) do
    {:ok, 4}
  end
  def(name_to_value(:double)) do
    {:ok, 5}
  end
  def(name_to_value(:string)) do
    {:ok, 6}
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
    [:bool, :bytes, :i16, :i32, :i64, :double, :string]
  end
  def(meta(:values)) do
    [0, 1, 2, 3, 4, 5, 6]
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
  def(member?(5)) do
    true
  end
  def(member?(6)) do
    true
  end
  def(member?(_)) do
    false
  end
  def(name?(:bool)) do
    true
  end
  def(name?(:bytes)) do
    true
  end
  def(name?(:i16)) do
    true
  end
  def(name?(:i32)) do
    true
  end
  def(name?(:i64)) do
    true
  end
  def(name?(:double)) do
    true
  end
  def(name?(:string)) do
    true
  end
  def(name?(_)) do
    false
  end
end