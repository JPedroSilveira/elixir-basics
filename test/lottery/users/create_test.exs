defmodule Lottery.Users.CreateTest do
  use ExUnit.Case
  use Lottery.DataCase
  alias Lottery.Users
  alias Users.User
  alias Lottery.Repo

  test "Should store user" do
    # Act
    {status, created_user} = create_user_by_email("email@email.com")
    # Assert
    assert status == :ok
    stored_user = Repo.get(User, created_user.id)
    assert not is_nil(stored_user)
  end

  test "Should reject multiple users with same email" do
    # Pre condition
    email = "email@email.com"
    {status, _info} = create_user_by_email(email)
    assert status == :ok
    # Act
    {status, info} = create_user_by_email(email)
    # Assert
    assert status == :error
    {message, _info} = info.errors[:email]
    assert message == "has already been taken"
  end

  defp create_user_by_email(email) do
    Users.create(%{email: email, password: "hash", name: "Joao"})
  end
end
