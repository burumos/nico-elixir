defmodule NicoWeb.NicoController do
  alias Nico.NicoSearch
  alias Nico.Services.NicoApi
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

    conditions = NicoSearch.fetch_conditions_by_user(conn.assigns.current_user)
    render(conn, :search, %{videos: videos, conditions: conditions})
  end

  def create_cond(conn, _params) do
    {:ok, condition} = NicoSearch.register_for_login_user(conn.body_params, conn.assigns.current_user)
    render(conn, "create_cond.json", %{condition: condition})
  end

  def delete_cond(conn, _params) do
    {:ok, _} = NicoSearch.delete_by_id(Map.get(conn.body_params, "id"))
    render(conn, "delete_cond.json")
  end
end
