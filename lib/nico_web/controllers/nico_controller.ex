defmodule NicoWeb.NicoController do
  alias Nico.Services.NicoApi
  alias Nico.Services.Helper
  require Logger
  # require Logger
  use NicoWeb, :controller

  def search(conn, _params) do
    query_params = conn.query_params

    videos = case Map.get(query_params, "word") do
      # videos = case params[:word] && String.length(params[:word]) > 0 do
      word when word != nil and word != "" -> NicoApi.search(word, Helper.default_value(query_params["limit"], 10))
      _ -> []
    end
    render(conn, :search, %{videos: videos})
  end

end
