import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dismoi, DismoiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "dqlMyPEiM9c6kD6oCIzdYvcx/Ytg20jMC2BQvjxU+HudhU03q7Zs0zM/fEY9AOhH",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
