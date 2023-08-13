defmodule NicoWeb.PageController do
  require Logger
  use NicoWeb, :controller

  def home(conn, _params) do
    # IO.inspect(conn.assigns[:current_user].id);
    # Logger.info("info message from PageController")

    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end
end
