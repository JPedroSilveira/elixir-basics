defmodule LotteryWeb.FallbackController do
  use LotteryWeb, :controller
  alias LotteryWeb.ErrorJSON

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(404)
    |> put_view(json: ErrorJSON)
    |> render(:error, status: :not_found)
  end

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(400)
    |> put_view(json: ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
