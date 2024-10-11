defmodule Lottery.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @all_params [:user_id, :name, :date]

  schema "events" do
    field :user_id, :integer
    field :name, :string
    field :date, :date
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @all_params)
    |> validate_length(:name, max: 255)
  end

end
