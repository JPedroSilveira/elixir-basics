defmodule Lottery.Events.Get do
  alias Lottery.Repo
  alias Lottery.Events.Event

  def call(id) do
    case Repo.get(Event, id) do
      nil -> {:error, :not_found}
      event -> {:ok, event}
    end
  end
end
