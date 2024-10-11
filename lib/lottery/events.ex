defmodule Lottery.Events do
  alias Lottery.Events.Create
  alias Lottery.Events.Get

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
end
