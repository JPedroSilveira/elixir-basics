defmodule Lottery.Users do
  alias Lottery.Users.Create
  alias Lottery.Users.Get

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
end
