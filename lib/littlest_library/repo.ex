defmodule LittlestLibrary.Repo do
  use Ecto.Repo,
    otp_app: :littlest_library,
    adapter: Ecto.Adapters.Postgres
end
