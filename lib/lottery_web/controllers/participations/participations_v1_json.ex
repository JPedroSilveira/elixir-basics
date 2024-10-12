defmodule LotteryWeb.Participations.ParticipationsV1JSON do
  def create(%{participation: participation}) do
    %{
      data: %{
        id: participation.id
      },
      message: "Participation added."
    }
  end

  def get_by_event(%{participations: participations}) do
    %{
      data: %{
        status: Enum.map(participations, fn participation -> %{
          event_id: participation.event_id,
          user_id: participation.user_id
        } end)
      }
    }
  end
end
