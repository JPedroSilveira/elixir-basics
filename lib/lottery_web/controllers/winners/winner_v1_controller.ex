defmodule LotteryWeb.Winners.WinnerV1Controller do
  use LotteryWeb, :controller
  alias Lottery.Winners
  alias Winners.Winner

  action_fallback LotteryWeb.FallbackController

  def show(conn, %{"id" => id}) do
    with {:ok, %Winner{} = winner} <- Winners.get_by_event(id) do
      conn
      |> put_status(200)
      |> render(:get, winner: winner)
    end
  end
end
