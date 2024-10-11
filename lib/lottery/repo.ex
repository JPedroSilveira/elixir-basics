defmodule Lottery.Repo do
  use Ecto.Repo,
    otp_app: :lottery,
    adapter: Ecto.Adapters.Postgres
end
