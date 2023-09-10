defmodule Nico.Services.UrlGenerator do
  def generate_get_url(base_url, params_map) do
    query_params = generate_query(params_map)

    if String.length(query_params) > 0 do
      "#{base_url}?#{query_params}"
    else
      base_url
    end
  end

  defp generate_query(params_map) do
    params_map
    |> Enum.map(fn {k, v} -> "#{k}=#{v}" end)
    |> Enum.join("&")
  end
end
