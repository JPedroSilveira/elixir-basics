defmodule LotteryWeb.Events.EventV1JSON do
  def create(%{event: event}) do
    %{
      data: %{
        id: event.id
      },
      message: "Event created."
    }
  end

  def get(%{event: event}) do
    %{
      data: %{
        id: event.id,
        user_id: event.user_id,
        name: event.name,
        date: event.date
      }
    }
  end
end
