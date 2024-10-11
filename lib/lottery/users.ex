defmodule Lottery.Users do
  alias Lottery.Users.Create
  alias Lottery.Users.Get
  alias Lottery.Users.Update

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
end
