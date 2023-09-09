defmodule Nico.NicoSearch do
  import Ecto.Query, warn: false
  alias Nico.Repo
  alias Nico.Search.NicoSearchCondition

  def fetch_conditions_by_user_id(user_id) do
    Repo.get_by(NicoSearchCondition, user_id: user_id)
  end

  def fetch_conditions_by_user(user) do
    Repo.preload(user, :nico_search_conditions).nico_search_conditions
  end

  def register(attr) do
    %NicoSearchCondition{}
    |> NicoSearchCondition.changeset(attr)
    |> Repo.insert()
  end

  def register_for_login_user(attr, user) do
    user
    |> Ecto.build_assoc(:nico_search_conditions)
    |> NicoSearchCondition.changeset(attr)
    |> Repo.insert()
  end

  def delete_by_id(id) do
    condition = Repo.get(NicoSearchCondition, id)
    Repo.delete(condition)
  end
end
