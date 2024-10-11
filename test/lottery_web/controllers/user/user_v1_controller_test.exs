defmodule LotteryWeb.User.UserV1ControllerTest do
  use LotteryWeb.ConnCase, async: true

  describe "Should create user" do
    test "Should create user" do
      # Input
      body = %{
        name: "João",
        email: "email@gmail.com",
        password: "password"
      }
      # Act & Assert
      id = build_conn()
      |> put_req_header("accept", "application/json")
      |> post("/api/v1/user", body)
      |> json_response(201)
      |> Map.get("data")
      |> Map.get("id")
      assert not is_nil(id)
    end

    test "Should fail to create invalid user" do
      # Input
      body = %{
        name: "João",
        email: "email@gmail.com"
      }
      # Act & Assert
      [error_message | _] = build_conn()
      |> put_req_header("accept", "application/json")
      |> post("/api/v1/user", body)
      |> json_response(400)
      |> Map.get("errors")
      |> Map.get("password")
      assert error_message == "can't be blank"
    end

    test "Should fail to create multiple users with same email" do
      # Input
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
      # Pre condition
      conn
      |> put_req_header("accept", "application/json")
      |> post("/api/v1/user", userOne)
      |> json_response(201)
      # Act & Assert
      [error_message | _] = conn
      |> put_req_header("accept", "application/json")
      |> post("/api/v1/user", userTwo)
      |> json_response(400)
      |> Map.get("errors")
      |> Map.get("email")
      assert error_message == "has already been taken"
    end
  end

  describe "Should fetch user" do
    test "Should fetch user by id" do
      # Pre condition
      id = create_user()
      # Act
      data = build_conn()
      |> put_req_header("accept", "application/json")
      |> get("/api/v1/user/#{id}")
      |> json_response(200)
      |> Map.get("data")
      # Assert
      assert not is_nil(data)
      assert data["id"] == id
      assert data["email"] == "email@gmail.com"
      assert data["name"] == "João Get"
    end

    test "Should return not found for non existent user" do
      # Act
      status = build_conn()
      |> put_req_header("accept", "application/json")
      |> get("/api/v1/user/20")
      |> json_response(404)
      |> Map.get("errors")
      |> Map.get("status")
      # Assert
      assert status == "not_found"
    end
  end

  defp create_user() do
    body = %{
      name: "João Get",
      email: "email@gmail.com",
      password: "password"
    }
    build_conn()
    |> put_req_header("accept", "application/json")
    |> post("/api/v1/user", body)
    |> json_response(201)
    |> Map.get("data")
    |> Map.get("id")
  end
end
