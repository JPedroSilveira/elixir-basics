defmodule Lottery.Participations.GetByEvent do
  import Ecto.Query
  alias Lottery.Repo
  alias Lottery.Participations.Participation

  def call(event_id) do
    query = from(p in Participation, where: p.event_id == ^event_id)
    case Repo.all(query) do
      nil -> {:error, :not_found}
      participations -> {:ok, participations}
    end
  end
end
