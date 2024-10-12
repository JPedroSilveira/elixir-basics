defmodule Lottery.Repo.Migrations.AddEventUserTable do
  use Ecto.Migration

  def change do
    create table("participation") do
      add :participation_id, :bigserial, primary_key: true
      add :event_id, references("events", with: [event_id: :event_id]), null: false
      add :user_id, references("users", with: [user_id: :user_id]), null: false
      timestamps()
    end
    create index("participation", [:user_id, :event_id], unique: true)
  end
end
