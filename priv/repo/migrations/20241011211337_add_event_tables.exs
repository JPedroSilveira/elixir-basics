defmodule Lottery.Repo.Migrations.AddEventTables do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :event_id, :bigserial, primary_key: true
      add :user_id, references("users", with: [user_id: :user_id])
      add :name, :string, length: 255, null: false
      add :date, :date, null: false
      timestamps()
    end
  end
end
