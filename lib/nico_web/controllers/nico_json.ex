defmodule NicoWeb.NicoJSON do

  def create_cond(%{condition: condition}) do
    %{condition: %{
      word: condition.word,
      limit: condition.limit,
      minimum_views: condition.minimum_views,
    }}
  end

  def delete_cond(_) do
    nil
  end
end
