defmodule LotteryWeb.User.UserV1JSON do
  def create(%{user: user}) do
    %{
      data: %{
        id: user.id
      },
      message: "User created."
    }
  end
end
