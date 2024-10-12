defmodule LotteryWeb.Events.EventV1ControllerTest do
  use LotteryWeb.ConnCase, async: true
  alias Lottery.Util.Test.UserUtil

  describe "Create event" do
    test "Should create event" do
      conn = build_conn()
      # [Pre requisite] Create user
      user_id = UserUtil.create(conn)
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
      user_id = UserUtil.create(conn)
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
end
