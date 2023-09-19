defmodule NicoWeb.NicoController do
  alias Nico.NicoSearch
  alias Nico.NicoVideo
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

  def show_bulk_set(conn, _params) do
    user = conn.assigns.current_user
    videos = NicoVideo.fetch_by_user(user)
    render(conn, :bulk_set, %{videos: videos})
  end

  def fetch_bulk(conn, _params) do
    user = conn.assigns.current_user
    NicoVideo.delete_by_user(user)
    NicoApi.bulk_fetch()
    # 下：動かない...
    # |> NicoVideo.register_bulk_for_login_user(conn.assigns.current_user)
    |> Enum.each(fn video -> NicoVideo.register_for_login_user(video, user) end)

    conn
    |> put_flash(:info, "更新しました!!")
    |> redirect(to: "/nico/bulk")
  end
end
