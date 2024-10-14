defmodule Lottery.Job.Winners.WinnersJob do
  use GenServer, restart: :transient
  alias Lottery.Events
  alias Lottery.Participations
  alias Lottery.Winners

  def start_link(run_interval) do
    GenServer.start_link(__MODULE__, run_interval, name: __MODULE__)
  end
  @impl true
  def init(run_interval) do
    IO.puts "Starting winners job"
    {:ok, run_interval, {:continue, :schedule_next_run}}
  end
  @impl true
  def handle_continue(:schedule_next_run, run_interval) do
    Process.send_after(self(), :perform_cron_work, run_interval)
    {:noreply, run_interval}
  end
  @impl true
  def handle_info(:perform_cron_work, run_interval) do
    now = DateTime.utc_now()
    Events.get_by_datetime_without_winner(now)
    |> process_events
    {:noreply, run_interval, {:continue, :schedule_next_run}}
  end
  defp process_events({:ok, events}) do
    case events do
      [] -> IO.puts "No event was found to sort a winner"
      non_empty_event_list -> process_events(non_empty_event_list)
    end
  end
  defp process_events({:error, _}) do
    IO.puts "Fail to fetch events to sort a winner"
  end
  defp process_events(events) do
    Enum.each(events, fn event ->
      process_event(event)
    end)
  end
  defp process_event(event) do
    Participations.get_by_event(event.id)
    |> sort_winner(event.id)
  end
  defp sort_winner({:ok, participants}, event_id) do
    case participants do
      # Implement handler to cancel the event
      [] -> IO.puts "Could not process event #{event_id} because it doesn't have any participant"
      non_empty_participant_list -> sort_winner(non_empty_participant_list)
    end
  end
  defp sort_winner({:error, _}, event_id) do
    IO.puts "Fail to fetch participants to sort a winner for event #{event_id}"
  end
  defp sort_winner(participants) do
    participants
    |> Enum.random()
    |> persist_winner()
  end
  defp persist_winner(participant) do
    IO.puts "Event #{participant.event_id} was sorted! The winner was #{participant.user_id}"
    Winners.create(%{
      event_id: participant.event_id,
      user_id: participant.user_id
    })
  end
end
