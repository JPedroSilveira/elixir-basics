defmodule LotteryWeb.Users.UserV1JSON do
  def create(%{user: user}) do
    %{
      data: %{
        id: user.id
      },
      message: "User created."
    }
  end

  def get(%{user: user}) do
    %{
      data: %{
        id: user.id,
        name: user.name,
        email: user.email
      }
    }
  end

  def update(%{user: user}) do
    %{
      data: %{
        id: user.id
      },
      message: "User updated."
    }
  end
end
