defmodule LotteryWeb.HealthCheck.HealthCheckontroller do
  use LotteryWeb, :controller
  alias LotteryWeb.HealthCheck.DatabaseHealthCheck

  def index(conn, _params) do
    DatabaseHealthCheck.verify_connection()
    |> get_status(conn)
  end

  defp get_status(:ok, conn) do
    conn
    |> put_status(200)
    |> json(%{status: "OK", database: "Up"})
  end

  defp get_status(:error, conn) do
    conn
    |> put_status(500)
    |> json(%{status: "Failure", database: "Down"})
  end
end
