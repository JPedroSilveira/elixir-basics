defmodule Lottery.Util.Test.UserUtil do
  use LotteryWeb.ConnCase, async: true

  def create(conn) do
    body = %{
      name: "João Get",
      email: "email@gmail.com",
      password: "password"
    }
    conn
    |> put_req_header("accept", "application/json")
    |> post("/api/v1/user", body)
    |> json_response(201)
    |> Map.get("data")
    |> Map.get("id")
  end
end
