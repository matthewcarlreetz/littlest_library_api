# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :littlest_library,
  ecto_repos: [LittlestLibrary.Repo]

# Configures the endpoint
config :littlest_library, LittlestLibraryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "i5UPBbbSfgP2YxXWoe0/jBuh9OHC340R37reXLewZYUoLpxTWYeOrmqCcCgendWv",
  render_errors: [view: LittlestLibraryWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LittlestLibrary.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :littlest_library, :pow,
  user: LittlestLibrary.Users.User,
  repo: LittlestLibrary.Repo

config :arc,
  storage: Arc.Storage.GCS,
  bucket: "littlest_libraries"

config :goth,
  json: "google-service-account.json" |> Path.expand() |> File.read!()

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
