defmodule LotteryWeb.HealthCheck.DatabaseHealthCheck do
  alias Lottery.Repo

  def verify_connection do
    case Repo.query("SELECT 1") do
      {:ok, _result} -> :ok
      {:error, _reason} -> :error
    end
  end
end
