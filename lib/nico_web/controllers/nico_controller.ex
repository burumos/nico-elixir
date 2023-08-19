defmodule NicoWeb.NicoController do
  alias Nico.Services.NicoApi
  import Nico.Services.Helper
  require Logger
  # require Logger
  use NicoWeb, :controller

  def search(conn, _params) do
    query_params = conn.query_params

    videos =
      case Map.get(query_params, "word") do
        word when word != nil and word != "" ->
          NicoApi.search(query_params)

        _ ->
          []
      end

    render(conn, :search, %{videos: videos})
  end
end
