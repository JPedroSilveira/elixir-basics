defmodule Lottery.Participations.Participation do
  use Ecto.Schema
  import Ecto.Changeset

  @all_params [:event_id, :user_id]

  schema "participation" do
    field :event_id, :integer
    field :user_id, :integer
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @all_params)
    |> validate_required(@all_params)
  end
end
