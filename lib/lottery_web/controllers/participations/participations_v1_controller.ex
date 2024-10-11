defmodule LotteryWeb.Participations.ParticipationsV1Controller do
  use LotteryWeb, :controller
  alias Lottery.Participations
  alias Participations.Participation

  action_fallback LotteryWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Participation{} = participation} <- Participations.create(params) do
      conn
      |> put_status(201)
      |> render(:create, participation: participation)
    end
  end

  def index(conn, %{"event_id" => event_id}) do
    with {:ok, participations} <- Participations.get_by_event(event_id) do
      conn
      |> put_status(200)
      |> render(:get_by_event, participations: participations)
    end
  end
end
