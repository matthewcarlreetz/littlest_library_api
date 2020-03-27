use Mix.Config

# Configure your database
config :littlest_library, LittlestLibrary.Repo,
  username: "matthewreetz",
  database: "littlest_library_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :littlest_library, LittlestLibraryWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
