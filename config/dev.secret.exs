use Mix.Config

# Configure your database
config :littlest_library, LittlestLibrary.Repo,
  username: "matthewreetz",
  database: "littlest_library_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
