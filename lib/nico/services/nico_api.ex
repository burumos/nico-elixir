defmodule Nico.Services.NicoApi do
  alias Nico.Services.UrlGenerator
  import Nico.Services.Helper

  def search(params) do
    case fetch_by_params(params) do
      %{ "data" => data } -> convert_videos(data)
      _ -> []
    end
  end

  def bulk_fetch() do
    [
      %{"word" => "mtg -mtga -mtgアリーナ -MMD",  "limit" => 5, "minimum_views" => 300},
      %{"word" => "sims -MMD -MikuMikuDance",  "limit" => 5, "minimum_views" => 100},
      %{"word" => "cities:skylines",  "limit" => 5, "minimum_views" => 500},
      %{"word" => "ets2 -MMD -切り抜き",  "limit" => 5, "minimum_views" => 100},
    ]
    |> Enum.map(fn condition -> search(condition) end)
    |> List.flatten()
  end

  defp fetch_by_params(params) do
    params
    |> generate_params_map()
    |> fetch()
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
      q: "",
      targets: "title,tags",
      _context: "private-nk.ex",
      _sort: "-startTime",
      _limit: "10",
      fields: "title,contentId,viewCounter,mylistCounter,likeCounter,lengthSeconds,thumbnailUrl,startTime,commentCounter",
    ]
    params = Keyword.merge(default_params, params_list)
    url = UrlGenerator.generate_get_url(
      "https://snapshot.search.nicovideo.jp/api/v2/snapshot/video/contents/search",
      params
    )

    url
    # |> IO.inspect() # debug
    |> URI.encode()
    |> Req.get!()
    |> Map.get(:body)
  end

  defp convert_videos(videos) do
    Enum.map(videos, fn video -> %{
      "content_id" => video["contentId"],
      "title" => video["title"],
      "thumbnail_url" => video["thumbnailUrl"],
      "start_time" => video["startTime"],
      "length_seconds" => video["lengthSeconds"],
      "comment_counter" => video["commentCounter"],
      "like_counter" => video["likeCounter"],
      "mylist_counter" => video["mylistCounter"],
      "view_counter" => video["viewCounter"],
    } end)
  end
end
