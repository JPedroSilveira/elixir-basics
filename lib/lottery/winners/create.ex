defmodule Lottery.Winners.Create do
  alias Lottery.Repo
  alias Lottery.Winners.Winner

  def call(params) do
    params
    |> Winner.changeset()
    |> Repo.insert()
  end
end
