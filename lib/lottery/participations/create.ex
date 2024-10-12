defmodule Lottery.Participations.Create do
  alias Lottery.Participations.Participation
  alias Lottery.Repo
  alias Lottery.Events.Event
  alias Lottery.Users.User

  def call(%{"event_id" => event_id, "user_id" => user_id} = params) do
    case Repo.get(Event, event_id) do
      nil -> {:error, :not_found}
      _ -> create(params, user_id)
    end
  end

  defp create(params, user_id) do
    case Repo.get(User, user_id) do
      nil -> {:error, :not_found}
      _ -> create(params)
    end
  end

  defp create(params) do
    params
    |> Participation.changeset()
    |> Repo.insert()
  end
end
