defmodule Nico.Services.NicoApi do
  alias Nico.Services.UrlGenerator
  import Nico.Services.Helper

  def search(params) do
    case fetch(generate_params_map(params)) do
      %{ "data" => data } -> data
      _ -> []
    end
  end

  defp generate_params_map(params) do
    %{
      q: params["word"],
      _limit: default_value(Map.get(params, "limit"), 10),
      "filters[viewCounter][gt]": Map.get(params, "minimum_views"),
    }
    |> Enum.filter(fn {_, v} -> !empty?(v) end)
  end

  defp fetch(params_list) do
    default_params = [
      q: "UTAU オリジナル",
      targets: "title,tags,description",
      _context: "private-nk.ex",
      _sort: "-startTime",
      _limit: "10",
      fields: "title,contentId,viewCounter,mylistCounter,likeCounter,lengthSeconds,thumbnailUrl,startTime,commentCounter",
    ]
    params = Keyword.merge(default_params, params_list)
    url = UrlGenerator.generate_get_url(
      "https://api.search.nicovideo.jp/api/v2/snapshot/video/contents/search",
      params
    )

    url
    |> IO.inspect() # debug
    |> URI.encode()
    |> Req.get!()
    |> Map.get(:body)
  end
end
