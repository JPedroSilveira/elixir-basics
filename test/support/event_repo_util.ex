defmodule Lottery.Util.Test.EventRepoUtil do
  alias Lottery.Events

  def create(user_id) do
    Events.create(%{user_id: user_id, name: "Event", date: "2024-10-12 10:00:00.00"})
  end
end
