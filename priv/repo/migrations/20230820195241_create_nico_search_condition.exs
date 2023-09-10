defmodule Nico.Repo.Migrations.CreateNicoSearchCondition do
  use Ecto.Migration

  def change do
    create table(:nico_search_conditions) do
      add :user_id, :integer, null: false
      add :word, :string, null: false
      add :minimum_views, :integer
      add :limit, :integer
      timestamps()
    end
  end
end
