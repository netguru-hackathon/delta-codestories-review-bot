use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :codestories_review_bot, CodestoriesReviewBotWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :codestories_review_bot, CodestoriesReviewBot.Repo,
  username: "postgres",
  password: System.get_env("POSTGRES_DB_PASSWORD") || "postgres",
  database: "codestories_review_bot_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
