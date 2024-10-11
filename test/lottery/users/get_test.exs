defmodule Lottery.Users.GetTest do
  use ExUnit.Case
  use Lottery.DataCase
  alias Lottery.Users

  test "Should fetch user by id" do
    # Pre condition
    {status, created_user} = create_user_by_email("email@email.com")
    assert status == :ok

    # Act
    {status, fetched_user} = Users.get(created_user.id)

    # Assert
    assert status == :ok
    assert created_user.name == fetched_user.name
    assert created_user.email == fetched_user.email
    assert is_nil(fetched_user.password)
    assert not is_nil(fetched_user.password_hash)
  end

  test "Should fetch different users by id" do
    # Pre condition
    {status, created_user_one} = create_user_by_email("one@email.com")
    assert status == :ok
    {status, created_user_two} = create_user_by_email("two@email.com")
    assert status == :ok

    # Act
    {status_one, fetched_user_one} = Users.get(created_user_one.id)
    {status_two, fetched_user_two} = Users.get(created_user_two.id)

    # Assert
    assert status_one == :ok
    assert status_two == :ok
    assert created_user_one.email == fetched_user_one.email
    assert fetched_user_two.email == fetched_user_two.email
  end

  defp create_user_by_email(email) do
    Users.create(%{email: email, password: "hash", name: "Joao"})
  end
end
