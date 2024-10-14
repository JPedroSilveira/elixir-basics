defmodule Lottery.Events.GetTest do
  use ExUnit.Case
  use Lottery.DataCase
  alias Lottery.Events
  alias Lottery.Util.Test.UserRepoUtil
  alias Lottery.Util.Test.EventRepoUtil

  test "Should fetch event by id" do
    # [Pre requisire] Create user
    {status, created_user} = UserRepoUtil.create("email@email.com")
    assert status == :ok
    {status, created_event} = EventRepoUtil.create(created_user.id)
    assert status == :ok

    # Act
    {status, fetched_event} = Events.get(created_event.id)

    # Assert
    assert status == :ok
    assert created_event.id == fetched_event.id
    assert created_event.user_id == fetched_event.user_id
    assert created_event.name == fetched_event.name
    assert created_event.date == fetched_event.date
  end

  test "Should fetch different users by id" do
    # [Pre requisire] Create user
    {status, created_user_one} = UserRepoUtil.create("email@email.com")
    assert status == :ok
    {status, created_user_two} = UserRepoUtil.create("email2@email.com")
    assert status == :ok
    {status, created_event_one} = EventRepoUtil.create(created_user_one.id)
    assert status == :ok
    {status, created_event_two} = EventRepoUtil.create(created_user_two.id)
    assert status == :ok

    # Act
    {status_one, fetched_event_one} = Events.get(created_event_one.id)
    {status_two, fetched_event_two} = Events.get(created_event_two.id)

    # Assert
    assert status_one == :ok
    assert status_two == :ok
    assert created_event_one.name == fetched_event_one.name
    assert created_event_two.name == fetched_event_two.name
    assert created_event_one.user_id == fetched_event_one.user_id
    assert created_event_two.user_id == fetched_event_two.user_id
    assert created_event_one.name == fetched_event_one.name
    assert created_event_two.name == fetched_event_two.name
    assert created_event_one.date == fetched_event_one.date
    assert created_event_two.date == fetched_event_two.date
  end
end
