defmodule Lottery.Events.CreateTest do
  use ExUnit.Case
  use Lottery.DataCase
  alias Lottery.Events
  alias Events.Event
  alias Lottery.Repo
  alias Lottery.Util.Test.UserRepoUtil
  alias Lottery.Util.Test.EventRepoUtil

  test "Should store event" do
    # [Pre requisire] Create user
    {status, created_user} = UserRepoUtil.create("email@email.com")
    assert status == :ok
    # Act
    {status, created_event} = EventRepoUtil.create(created_user.id)
    # Assert
    assert status == :ok
    stored_event = Repo.get(Event, created_event.id)
    assert not is_nil(stored_event)
  end
end
