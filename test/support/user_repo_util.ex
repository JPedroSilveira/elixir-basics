defmodule Lottery.Util.Test.UserRepoUtil do
  alias Lottery.Users

  def create(email) do
    Users.create(%{email: email, password: "password", name: "Joao"})
  end
end
