defmodule LotteryWeb.Winners.WinnerV1JSON do
  def get(%{winner: winner}) do
    %{
      data: %{
        user_id: winner.user_id,
        event_id: winner.event_id
      }
    }
  end
end
