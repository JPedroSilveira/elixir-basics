defmodule Lottery.Users.UpdateTest do
  use ExUnit.Case
  use Lottery.DataCase
  alias Lottery.Users
  alias Lottery.Util.Test.UserRepoUtil

  test "Should update all fields" do
    # Pre condition
    {status, created_user} = UserRepoUtil.create("email@email.com")
    assert status == :ok

    # Act
    {status, _updated_user} = Users.update(%{"id" => created_user.id, "email" => "2@email.com", "password" => "2", "name" => "Pedro"})
    assert status == :ok

    # Assert
    {status, fetched_user} = Users.get(created_user.id)
    assert status == :ok
    assert fetched_user.id == created_user.id
    assert fetched_user.name == "Pedro"
    assert fetched_user.email == "2@email.com"
    assert is_nil(fetched_user.password)
    assert not is_nil(fetched_user.password_hash)
    assert Pbkdf2.verify_pass("2", fetched_user.password_hash)
  end

  test "Should update only email" do
    # Pre condition
    {status, created_user} = UserRepoUtil.create("email@email.com")
    assert status == :ok

    # Act
    {status, _updated_user} = Users.update(%{"id" => created_user.id, "email" => "2@email.com"})
    assert status == :ok

    # Assert
    {status, fetched_user} = Users.get(created_user.id)
    assert status == :ok
    assert fetched_user.id == created_user.id
    assert fetched_user.name == "Joao"
    assert fetched_user.email == "2@email.com"
    assert is_nil(fetched_user.password)
    assert not is_nil(fetched_user.password_hash)
    assert Pbkdf2.verify_pass("password", fetched_user.password_hash)
  end

  test "Should update only name" do
    # Pre condition
    {status, created_user} = UserRepoUtil.create("email@email.com")
    assert status == :ok

    # Act
    {status, _updated_user} = Users.update(%{"id" => created_user.id, "name" => "Pedro"})
    assert status == :ok

    # Assert
    {status, fetched_user} = Users.get(created_user.id)
    assert status == :ok
    assert fetched_user.id == created_user.id
    assert fetched_user.name == "Pedro"
    assert fetched_user.email == "email@email.com"
    assert is_nil(fetched_user.password)
    assert not is_nil(fetched_user.password_hash)
    assert Pbkdf2.verify_pass("password", fetched_user.password_hash)
  end

  test "Should update only password" do
    # Pre condition
    {status, created_user} = UserRepoUtil.create("email@email.com")
    assert status == :ok

    # Act
    {status, _updated_user} = Users.update(%{"id" => created_user.id, "password" => "password2"})
    assert status == :ok

    # Assert
    {status, fetched_user} = Users.get(created_user.id)
    assert status == :ok
    assert fetched_user.id == created_user.id
    assert fetched_user.name == "Joao"
    assert fetched_user.email == "email@email.com"
    assert is_nil(fetched_user.password)
    assert not is_nil(fetched_user.password_hash)
    assert Pbkdf2.verify_pass("password2", fetched_user.password_hash)
  end
end
