defmodule Lottery.Events.GetByDatetimeWithoutWinner do
  import Ecto.Query
  alias Lottery.Repo
  alias Lottery.Events.Event
  alias Lottery.Winners.Winner

  def call(datetime) do
    query = from(e in Event, left_join: w in Winner, on: w.event_id == e.event_id, where: is_nil(w.id) and e.date <= ^datetime )
    case Repo.all(query) do
      nil -> {:error, :not_found}
      events -> {:ok, events}
    end
  end
end
