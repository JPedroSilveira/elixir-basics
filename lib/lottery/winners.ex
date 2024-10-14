defmodule Lottery.Winners do
  alias Lottery.Winners.Create
  alias Lottery.Winners.GetByEvent

  defdelegate create(params), to: Create, as: :call
  defdelegate get_by_event(event_id), to: GetByEvent, as: :call
end
