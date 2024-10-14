defmodule Lottery.Winners.GetByEvent do
  alias Lottery.Repo
  alias Lottery.Winners.Winner

  def call(event_id) do
    case Repo.get_by(Winner, event_id: event_id) do
      nil -> {:error, :not_found}
      winner -> {:ok, winner}
    end
  end
end
