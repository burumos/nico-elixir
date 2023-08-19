defmodule Nico.Services.Helper do
  def default_value(value, default) do
    if !empty?(value) do value else default end
  end

  def empty?(value) when value == nil or value == "", do: true
  def empty?(_), do: false
end
