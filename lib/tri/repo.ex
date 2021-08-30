defmodule Tri.Repo do
  use Ecto.Repo,
    otp_app: :tri,
    adapter: Ecto.Adapters.Postgres
end
