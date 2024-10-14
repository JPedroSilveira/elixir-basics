defmodule Lottery.Participations.Create do
  alias Lottery.Participations.Participation
  alias Lottery.Repo
  alias Lottery.Events
  alias Lottery.Users
  alias Lottery.Winners

  def call(%{"event_id" => event_id, "user_id" => user_id} = params) do
    case Events.get(event_id) do
      {:error, :not_found} -> {:error, :not_found}
      _ -> create(params, event_id, user_id)
    end
  end

  defp create(params, event_id, user_id) do
    case Users.get(user_id) do
      {:error, :not_found} -> {:error, :not_found}
      _ -> create(params, event_id)
    end
  end

  defp create(params, event_id) do
    IO.inspect(Winners.get_by_event(event_id))
    case Winners.get_by_event(event_id) do
      {:error, :not_found} -> create(params)
      _ -> {:error, :bad_request}
    end
  end

  defp create(params) do
    params
    |> Participation.changeset()
    |> Repo.insert()
  end
end
