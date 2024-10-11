defmodule Lottery.Users.Create do
  alias Lottery.Users.User
  alias Lottery.Repo

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
