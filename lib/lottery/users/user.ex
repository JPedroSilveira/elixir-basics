defmodule Lottery.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @all_params [:name, :email, :password]

  schema "users" do
      field :name, :string
      field :email, :string
      field :password_hash, :string
      field :password, :string, virtual: true
      timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @all_params)
    |> validate_required(@all_params)
    |> validate_general_fields
    |> validate_password
  end

  def changeset(user, params) do
    user
    |> cast(params, @all_params)
    |> validate_update
  end

  defp validate_update(changeset) do
    if Map.has_key?(changeset.changes, :password), do: validate_password(changeset), else: changeset
    |> validate_general_fields
  end

  defp validate_general_fields(changeset) do
    changeset
    |> validate_length(:name, max: 255)
    |> validate_length(:email, max: 255)
    |> validate_format(:email, ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/)
    |> validate_length(:password, max: 72)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_length(:password, min: 1, max: 72)
    |> hash_password()
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    changeset
    |> change(%{password_hash: Pbkdf2.hash_pwd_salt(password)})
  end

  defp hash_password(changeset), do: changeset
end
