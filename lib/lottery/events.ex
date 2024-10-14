defmodule Lottery.Events do
  alias Lottery.Events.Create
  alias Lottery.Events.Get
  alias Lottery.Events.GetByDatetimeWithoutWinner

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate get_by_datetime_without_winner(datetime), to: GetByDatetimeWithoutWinner, as: :call
end
