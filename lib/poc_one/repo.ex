defmodule PocOne.Repo do
  use Ecto.Repo,
    otp_app: :poc_one,
    adapter: Ecto.Adapters.Postgres
end
