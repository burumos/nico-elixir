defmodule Nico.NicoVideo do
  import Ecto.Query, warn: false
  alias Nico.Repo
  alias Nico.Search.NicoVideo
  # alias Ecto.Multi

  # TODO: 一括登録を動くようにする
  # def register_bulk_for_login_user(videos, user) do
  #   # rows =
  #   # videos
  #   # |> Enum.map(fn video ->
  #   #   Ecto.build_assoc(user, :nico_videos)
  #   #   |> NicoVideo.changeset(video)
  #   # end)
  #   # |> IO.inspect()
  #   # Repo.insert_all(NicoVideo, rows)

  #   Ecto.Multi.new()
  #   |> Multi.insert_all(:insert_videos, NicoVideo, videos)
  #   # |> Multi.run(:validate_changeset, fn _, %{insert_videos: {:ok, _}} -> :ok end)
  #   |> Repo.transaction()
  # end

  def register_for_login_user(attr, user) do
    user
    |> Ecto.build_assoc(:nico_videos)
    |> NicoVideo.changeset(attr)
    |> Repo.insert()
  end

  def fetch_by_user(user) do
    Repo.preload(user, :nico_videos).nico_videos
  end

  def delete_by_user(user) do
    Repo.delete_all(from(v in NicoVideo, where: v.user_id == ^user.id))
  end
end
