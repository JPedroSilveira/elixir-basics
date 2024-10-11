defmodule LotteryWeb.Users.UserV1Controller do
  use LotteryWeb, :controller
  alias Lottery.Users
  alias Users.User

  action_fallback LotteryWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do
      conn
      |> put_status(201)
      |> render(:create, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get(id) do
      conn
      |> put_status(200)
      |> render(:get, user: user)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Users.update(params) do
      conn
      |> put_status(200)
      |> render(:update, user: user)
    end
  end
end
