defmodule Nico.Search.NicoSearchCondition do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nico_search_conditions" do
    # field :user_id, :integer
    field :word, :string
    field :limit, :integer
    field :minimum_views, :integer
    timestamps()

    belongs_to :user, Nico.Accouts.User
  end

  def changeset(search_condition, attrs) do
    search_condition
    |> cast(attrs, [:word, :limit, :minimum_views])
    |> validate_required([:word])
  end

  defimpl Jason.Encoder, for: Nico.Search.NicoSearchCondition do
    def encode(value, opts) do
      Jason.Encode.map(Map.take(value, [:id, :word, :limit, :minimum_views]), opts)
    end
  end
end
