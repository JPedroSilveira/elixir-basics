defmodule Lottery.Participations.GetByEvent do
  alias Lottery.Repo
  alias Lottery.Participations.Participation

  def call(event_id) do
    case Repo.get_by(Participation, event_id: event_id) do
      nil -> {:error, :not_found}
      participation -> {:ok, participation}
    end
  end
end
