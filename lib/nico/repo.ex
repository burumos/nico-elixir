defmodule Nico.Repo do
  use Ecto.Repo,
    otp_app: :nico,
    adapter: Ecto.Adapters.SQLite3
end
