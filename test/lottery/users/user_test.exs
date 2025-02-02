defmodule Lottery.Users.UserTest do
  use ExUnit.Case
  alias Lottery.Users.User
  alias Lottery.Util.StringUtil

  test "Should accept valid user" do
    # Act
    result = User.changeset(%{email: "email@email.com", password: "hash", name: "Joao"})
    # Assert
    assert result.valid? == true
  end

  test "Should hash password" do
    # Act
    result = User.changeset(%{email: "email@email.com", password: "hash", name: "Joao"})
    # Assert
    assert result.valid? == true
    password_hash = result.changes.password_hash
    assert String.length(password_hash) == 131
  end

  describe "Should validate user name" do
    test "Should reject user without a name" do
      # Act
      result = User.changeset(%{email: "email@email.com", password: "hash"})
      # Assert
      assert result.valid? == false
      assert elem(result.errors[:name], 0) == "can't be blank"
    end

    test "Should reject user with empty name" do
      # Act
      result = User.changeset(%{email: "email@email.com", password: "hash", name: ""})
      # Assert
      assert result.valid? == false
      {message, _info} = result.errors[:name]
      assert message == "can't be blank"
    end

    test "Should reject user with name greater than 255" do
      # Act
      result = User.changeset(%{email: "email@email.com", password: "hash", name: StringUtil.generate(256)})
      # Assert
      assert result.valid? == false
      {message, info} = result.errors[:name]
      assert message == "should be at most %{count} character(s)"
      assert info[:count] == 255
    end
  end

  describe "Should validate user email" do
    test "Should reject user without an email" do
      # Act
      result = User.changeset(%{name: "Pedro", password: "hash"})
      # Assert
      assert result.valid? == false
      {message, _info} = result.errors[:email]
      assert message == "can't be blank"
    end

    test "Should reject user with an empty email" do
      # Act
      result = User.changeset(%{name: "Pedro", password: "hash", email: ""})
      # Assert
      assert result.valid? == false
      {message, _info} = result.errors[:email]
      assert message == "can't be blank"
    end

    test "Should reject user with invalid formatted email" do
      # Act
      result = User.changeset(%{name: "Pedro", password: "hash", email: "joao"})
      # Assert
      assert result.valid? == false
      {message, _info} = result.errors[:email]
      assert message == "has invalid format"
    end

    test "Should reject user with email greater than 255" do
      # Act
      result = User.changeset(%{email: "#{StringUtil.generate(246)}@email.com", password: "hash", name: "Joao"})
      # Assert
      assert result.valid? == false
      {message, info} = result.errors[:email]
      assert message == "should be at most %{count} character(s)"
      assert info[:count] == 255
    end
  end

  describe "Should validate user password" do
    test "Should reject user without password" do
      # Act
      result = User.changeset(%{name: "Pedro", email: "email@email.com"})
      # Assert
      assert result.valid? == false
      {message, _info} = result.errors[:password]
      assert message == "can't be blank"
    end

    test "Should reject user with empty password" do
      # Act
      result = User.changeset(%{name: "Pedro", email: "email@email.com", password: ""})
      # Assert
      assert result.valid? == false
      {message, _info} = result.errors[:password]
      assert message == "can't be blank"
    end

    test "Should reject user with password greater than 72" do
      # Act
      result = User.changeset(%{email: "email@email.com", password: StringUtil.generate(73), name: "Joao"})
      assert result.valid? == false
      # Assert
      {message, info} = result.errors[:password]
      assert message == "should be at most %{count} character(s)"
      assert info[:count] == 72
    end
  end
end
