defmodule Lottery.Events.Create do
  alias Lottery.Events.Event
  alias Lottery.Repo

  def call(params) do
    params
    |> Event.changeset()
    |> Repo.insert()
  end
end
