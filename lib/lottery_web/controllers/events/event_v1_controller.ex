defmodule LotteryWeb.Events.EventV1Controller do
  use LotteryWeb, :controller
  alias Lottery.Events
  alias Events.Event

  action_fallback LotteryWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Event{} = event} <- Events.create(params) do
      conn
      |> put_status(201)
      |> render(:create, event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Event{} = event} <- Events.get(id) do
      conn
      |> put_status(200)
      |> render(:get, event: event)
    end
  end
end
