defmodule Nico.Repo.Migrations.CreateNicoVideo do
  use Ecto.Migration

  def change do
    create table(:nico_video) do
      add :user_id, :integer, null: false
      add :content_id, :string, null: false
      add :title, :string
      add :length_seconds, :integer
      add :thumbnail_url, :string
      add :start_time, :naive_datetime
      add :view_counter, :integer
      add :mylist_counter, :integer
      add :like_counter, :integer
      add :comment_counter, :integer
      timestamps()
    end
  end
end
