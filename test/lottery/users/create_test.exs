defmodule Lottery.Users.CreateTest do
  use ExUnit.Case
  use Lottery.DataCase
  alias Lottery.Users.Create
  alias Lottery.Users.User
  alias Lottery.Repo

  test "Should store user" do
    result = Create.call(%{email: "email@email.com", password: "hash", name: "Joao"})
    {status, created_user} = result
    assert status == :ok
    stored_user = Repo.get(User, created_user.id)
    assert not is_nil(stored_user)
  end

  test "Should reject multiple users with same email" do
    email = "email@email.com"
    resultOne = create_user_by_email(email)
    {status, _info} = resultOne
    assert status == :ok
    resultTwo = create_user_by_email(email)
    {status, info} = resultTwo
    assert status == :error
    {message, _info} = info.errors[:email]
    assert message == "has already been taken"
  end

  defp create_user_by_email(email) do
    Create.call(%{email: email, password: "hash", name: "Joao"})
  end
end
