defmodule LotteryWeb.FallbackController do
  use LotteryWeb, :controller
  alias LotteryWeb.ErrorJSON

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(400)
    |> put_view(json: ErrorJSON)
    |> render(:bad_request, changeset: changeset)
  end
end
