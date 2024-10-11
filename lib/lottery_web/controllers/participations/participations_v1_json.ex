defmodule LotteryWeb.Participations.ParticipationsV1JSON do
  def create(%{participation: participation}) do
    %{
      message: "Participation added."
    }
  end

  def get_by_event(%{participations:  participations}) do
    %{
      data: %{
        status: "OK"
      }
    }
  end
end
