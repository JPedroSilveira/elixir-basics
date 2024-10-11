defmodule Lottery.Participations do
  alias Lottery.Participations.Create
  alias Lottery.Participations.GetByEvent

  defdelegate create(params), to: Create, as: :call
  defdelegate get_by_event(event_id), to: GetByEvent, as: :call
end
