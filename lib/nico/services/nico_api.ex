defmodule Nico.Services.NicoApi do
  alias Nico.Services.UrlGenerator

  def search(word, limit) do
    IO.inspect("word: #{word}, limit: #{limit}")
    case fetch(%{q: word, _limit: limit}) do
      %{ "data" => data } -> data
      _ -> []
    end
  end

  defp fetch(params_map) do
    default_params = %{
      q: "UTAU オリジナル",
      targets: "title,tags,description",
      _context: "private-nk.ex",
      _sort: "-startTime",
      _limit: "10",
      fields: "title,contentId,viewCounter,mylistCounter,likeCounter,lengthSeconds,thumbnailUrl,startTime,commentCounter",
    }
    params = Map.merge(default_params, params_map)
    url = UrlGenerator.generate_get_url(
      "https://api.search.nicovideo.jp/api/v2/snapshot/video/contents/search",
      params
    )

    url
    |> IO.inspect()
    |> URI.encode()
    |> Req.get!()
    |> Map.get(:body)
  end
end
