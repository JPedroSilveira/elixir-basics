defmodule Lottery.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :user_id, :bigserial, primary_key: true
      add :name, :string, length: 255, null: false
      add :email, :string, length: 255, null: false, unique: true
      add :password_hash, :string, length: 64, null: false
      timestamps()
    end
    create index("users", [:email], unique: true)
  end
end
