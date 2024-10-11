defmodule Lottery.Users.Get do
  alias Lottery.Repo
  alias Lottery.Users.User

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
