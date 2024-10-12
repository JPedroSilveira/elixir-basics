defmodule Lottery.Events.EventTest do
  use ExUnit.Case
  alias Lottery.Events.Event
  alias Lottery.Util.StringUtil

  test "Should accept valid event" do
    # Act
    result = Event.changeset(%{user_id: "1", name: "Big event", date: "2024-10-12 10:00:00.00"})
    # Assert
    assert result.valid? == true
  end

  describe "Should validate event name" do
    test "Should reject event without a name" do
      # Act
      result = Event.changeset(%{user_id: "1", date: "2024-10-12 10:00:00.00"})
      # Assert
      assert result.valid? == false
      {message, _info} = result.errors[:name]
      assert message == "can't be blank"
    end

    test "Should reject event with name bigger then 255 characters" do
      # Act
      result = Event.changeset(%{user_id: "1", name: StringUtil.generate(256), date: "2024-10-12 10:00:00.00"})
      # Assert
      assert result.valid? == false
      {message, info} = result.errors[:name]
      assert message == "should be at most %{count} character(s)"
      assert info[:count] == 255
    end
  end

  describe "Should validate event user_id" do
    test "Should reject event without a user_id" do
      # Act
      result = Event.changeset(%{name: "Big event", date: "2024-10-12 10:00:00.00"})
      # Assert
      assert result.valid? == false
      {message, _info} = result.errors[:user_id]
      assert message == "can't be blank"
    end
  end

  describe "Should validate event date" do
    test "Should reject event without a date" do
      # Act
      result = Event.changeset(%{user_id: 1, name: "Big event"})
      # Assert
      assert result.valid? == false
      {message, _info} = result.errors[:date]
      assert message == "can't be blank"
    end
    test "Should reject event with invalid date" do
      # Act
      result = Event.changeset(%{user_id: 1, name: "Big event", date: "Invalid"})
      # Assert
      assert result.valid? == false
      {message, _info} = result.errors[:date]
      assert message == "is invalid"
    end
    test "Should reject event with empty date" do
      # Act
      result = Event.changeset(%{user_id: 1, name: "Big event", date: ""})
      # Assert
      assert result.valid? == false
      {message, _info} = result.errors[:date]
      assert message == "can't be blank"
    end
  end

end
