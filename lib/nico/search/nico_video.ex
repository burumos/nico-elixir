defmodule Nico.Search.NicoVideo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nico_video" do
    # field :user_id, :integer
    field :content_id, :string
    field :title, :string
    field :length_seconds, :integer
    field :thumbnail_url, :string
    field :start_time, :naive_datetime
    field :view_counter, :integer
    field :mylist_counter, :integer
    field :like_counter, :integer
    field :comment_counter, :integer
    timestamps()

    belongs_to :user, Nico.Accouts.User
  end

  def changeset(video, attrs) do
    video
    |> cast(attrs, [
      :content_id,
      :title,
      :length_seconds,
      :thumbnail_url,
      :start_time,
      :view_counter,
      :mylist_counter,
      :like_counter,
      :comment_counter
    ])
    |> validate_required([:content_id])
  end
end
