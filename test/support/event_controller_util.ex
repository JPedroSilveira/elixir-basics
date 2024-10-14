defmodule Lottery.Util.Test.EventControllerUtil do
  use LotteryWeb.ConnCase, async: true

  def create(conn, user_id) do
    body = %{
      user_id: user_id,
      name: "Event",
      date: "2024-10-12 10:00:00"
    }
    conn
    |> put_req_header("accept", "application/json")
    |> post("/api/v1/event", body)
    |> json_response(201)
    |> Map.get("data")
    |> Map.get("id")
  end
end
