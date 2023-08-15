defmodule Nico.Services.UrlGenerator do
  def generate_get_url(base_url, params_map) do
    query_params = generate_query(params_map)

    IO.inspect("before #{query_params}")
    if String.length(query_params) > 0 do
      "#{base_url}?#{query_params}"
    else
      IO.inspect(" return only base_url")
      base_url
    end
  end

  defp generate_query(params_map) do
    params_map
    # |> Enum.map(fn {k, v} -> "#{k}=#{URI.encode(v)}" end)
    |> Enum.map(fn {k, v} -> "#{k}=#{v}" end)
    |> Enum.join("&")
    # |> IO.inspect()
  end
end
