defmodule LotteryWeb.Users.UserV1ControllerTest do
  use LotteryWeb.ConnCase, async: true
  alias Lottery.Util.Test.UserControllerUtil

  describe "Create user" do
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

  describe "Fetch user" do
    test "Should fetch user by id" do
      conn = build_conn()
      # Pre condition
      id = UserControllerUtil.create(conn)
      # Act
      data = conn
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

  describe "Update user" do
    test "Should update user" do
      conn = build_conn()
      # Pre condition
      expected_id = UserControllerUtil.create(conn)
      # Input
      body = %{
        name: "João Put",
        email: "put@gmail.com"
      }
      # Act & Assert response
      actual_id = conn
      |> put_req_header("accept", "application/json")
      |> put("/api/v1/user/#{expected_id}", body)
      |> json_response(200)
      |> Map.get("data")
      |> Map.get("id")
      assert not is_nil(actual_id)
      assert actual_id == expected_id
      # Assert data was updated
      data = build_conn()
      |> put_req_header("accept", "application/json")
      |> get("/api/v1/user/#{actual_id}")
      |> json_response(200)
      |> Map.get("data")
      # Assert
      assert not is_nil(data)
      assert data["id"] == actual_id
      assert data["email"] == "put@gmail.com"
      assert data["name"] == "João Put"
    end

    test "Should fail to update given invalid id" do
      # Input
      body = %{
        name: "João Put",
        email: "put@gmail.com"
      }
      # Act & Assert
      response_status = build_conn()
      |> put_req_header("accept", "application/json")
      |> put("/api/v1/user/99", body)
      |> json_response(404)
      |> Map.get("errors")
      |> Map.get("status")
      assert response_status == "not_found"
    end

    test "Should failt to update given invalid field" do
      conn = build_conn()
      # Pre condition
      id = UserControllerUtil.create(conn)
      # Input
      body = %{
        email: "invalid mail"
      }
      # Act & Assert response
      [error_message | _] = conn
      |> put_req_header("accept", "application/json")
      |> put("/api/v1/user/#{id}", body)
      |> json_response(400)
      |> Map.get("errors")
      |> Map.get("email")
      assert error_message == "has invalid format"
    end

  end
end
