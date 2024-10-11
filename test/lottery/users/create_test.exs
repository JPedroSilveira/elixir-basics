defmodule Lottery.Users.CreateTest do
  use ExUnit.Case
  use Lottery.DataCase
  alias Lottery.Users.Create
  alias Lottery.Users.User
  alias Lottery.Repo

  test "Should store user" do
    result = Create.call(%{email: "email@email.com", password: "hash", name: "Joao"})
    assert elem(result, 0) == :ok
    created_user = elem(result, 1)
    stored_user = Repo.get(User, created_user.id)
    assert not is_nil(stored_user)
  end
end
