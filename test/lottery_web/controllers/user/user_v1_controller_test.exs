defmodule LotteryWeb.User.UserV1ControllerTest do
  use LotteryWeb.ConnCase, async: true

  describe "Should perform create user request" do
    test "Should create user" do
      body = %{
        name: "João",
        email: "email@gmail.com",
        password: "password"
      }
      id = build_conn()
      |> put_req_header("accept", "application/json")
      |> post("/api/v1/user", body)
      |> json_response(201)
      |> Map.get("data")
      |> Map.get("id")
      assert not is_nil(id)
    end

    test "Should fail to create invalid user" do
      body = %{
        name: "João",
        email: "email@gmail.com"
      }
      [error_message | _] = build_conn()
      |> put_req_header("accept", "application/json")
      |> post("/api/v1/user", body)
      |> json_response(400)
      |> Map.get("errors")
      |> Map.get("password")
      assert error_message == "can't be blank"
    end

    test "Should fail to create multiple users with same email" do
      userOne = %{
        name: "João",
        email: "email@gmail.com",
        password: "password"
      }
      userTwo = %{
        name: "Pedro",
        email: "email@gmail.com",
        password: "password"
      }
      conn = build_conn()

      conn
      |> put_req_header("accept", "application/json")
      |> post("/api/v1/user", userOne)
      |> json_response(201)

      [error_message | _] = conn
      |> put_req_header("accept", "application/json")
      |> post("/api/v1/user", userTwo)
      |> json_response(400)
      |> Map.get("errors")
      |> Map.get("email")
      assert error_message == "has already been taken"
    end
  end
end
