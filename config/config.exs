# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tri,
  ecto_repos: [Tri.Repo]

# Configures the endpoint
config :tri, TriWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sSkouAt9umLTGUIutBFXt0liB3ajVP6+nqDO5IXf8voPQoRsT/3xuGodIVaBKeue",
  render_errors: [view: TriWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Tri.PubSub,
  live_view: [signing_salt: "2A9jVHSb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
