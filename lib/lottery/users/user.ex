defmodule Lottery.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:name, :email, :password]
  @hash_length 64

  schema "users" do
      field :name, :string
      field :email, :string
      field :password_hash, :string
      field :password, :string, virtual: true
      timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:name, max: 255)
    |> validate_length(:email, max: 255)
    |> validate_format(:email, ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/)
    |> validate_length(:password, max: 72)
    |> hash_password()
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    changeset
    |> change(%{password_hash: Pbkdf2.Base.hash_password(password, Pbkdf2.Base.gen_salt(), length: @hash_length, format: :modular)})
  end

  defp hash_password(changeset), do: changeset
end
