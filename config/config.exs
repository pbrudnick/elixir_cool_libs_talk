# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :species_app,
  ecto_repos: [SpeciesApp.Repo]

# Configures the endpoint
config :species_app, SpeciesAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fxOFEKoIVUHcTIysqHoIPiC5IQ1SyuUTy+9EaLN50DUVPBUJPvoN8RcWR4qILp/x",
  render_errors: [view: SpeciesAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SpeciesApp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
