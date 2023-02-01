defmodule Dismoi.Repo do
  use Ecto.Repo,
    otp_app: :dismoi,
    adapter: Ecto.Adapters.SQLite3
end
