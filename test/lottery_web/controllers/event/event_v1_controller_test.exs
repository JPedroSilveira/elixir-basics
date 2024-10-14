defmodule LotteryWeb.Events.EventV1ControllerTest do
  use LotteryWeb.ConnCase, async: true
  alias Lottery.Util.Test.UserControllerUtil
  alias Lottery.Util.Test.EventControllerUtil

  describe "Create event" do
    test "Should create event" do
      conn = build_conn()
      # [Pre requisite] Create user
      user_id = UserControllerUtil.create(conn)
      # Input
      body = %{
        user_id: user_id,
        name: "Event",
        date: "2024-10-12 10:00:00"
      }
      # Act & Assert
      id = conn
      |> put_req_header("accept", "application/json")
      |> post("/api/v1/event", body)
      |> json_response(201)
      |> Map.get("data")
      |> Map.get("id")
      assert not is_nil(id)
    end
    test "Should fail to create invalid event" do
      conn = build_conn()
      # [Pre requisite] Create user
      user_id = UserControllerUtil.create(conn)
      # Input without date
      body = %{
        user_id: user_id,
        name: "Event"
      }
      # Act & Assert
      [error_message | _] = conn
      |> put_req_header("accept", "application/json")
      |> post("/api/v1/event", body)
      |> json_response(400)
      |> Map.get("errors")
      |> Map.get("date")
      assert error_message == "can't be blank"
    end
  end

  describe "Fetch event" do
    test "Should fetch event by id" do
      conn = build_conn()
      # Pre condition
      user_id = UserControllerUtil.create(conn)
      event_id = EventControllerUtil.create(conn, user_id)
      # Act
      data = conn
      |> put_req_header("accept", "application/json")
      |> get("/api/v1/event/#{event_id}")
      |> json_response(200)
      |> Map.get("data")
      # Assert
      assert not is_nil(data)
      assert data["id"] == event_id
      assert data["date"] == "2024-10-12T10:00:00"
      assert data["name"] == "Event"
    end

    test "Should return not found for non existent event" do
      # Act
      status = build_conn()
      |> put_req_header("accept", "application/json")
      |> get("/api/v1/event/20")
      |> json_response(404)
      |> Map.get("errors")
      |> Map.get("status")
      # Assert
      assert status == "not_found"
    end
  end
end
