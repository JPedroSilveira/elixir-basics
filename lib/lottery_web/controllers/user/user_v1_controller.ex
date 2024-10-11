defmodule LotteryWeb.User.UserV1Controller do
  use LotteryWeb, :controller
  alias Lottery.Users.User
  alias Lottery.Users.Create

  action_fallback LotteryWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Create.call(params) do
      conn
      |> put_status(201)
      |> render(:create, user: user)
    end

  end
end
