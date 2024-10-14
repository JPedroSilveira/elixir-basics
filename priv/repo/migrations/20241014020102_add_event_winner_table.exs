defmodule Lottery.Repo.Migrations.AddEventWinnerTable do
  use Ecto.Migration

  def change do
    create table(:winner) do
      add :winner_id, :bigserial, primary_key: true
      add :event_id, references("events", with: [event_id: :event_id]), null: false
      add :user_id, references("users", with: [user_id: :user_id]), null: false
      timestamps()
    end
    create index(:winner, [:event_id], unique: true)
  end
end
