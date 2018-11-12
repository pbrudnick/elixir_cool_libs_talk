defmodule SpeciesApp.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec
    import Cachex.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(SpeciesApp.Repo, []),
      # Start the endpoint when the application starts
      supervisor(SpeciesAppWeb.Endpoint, []),
      # Start your own worker by calling: SpeciesApp.Worker.start_link(arg1, arg2, arg3)
      # worker(SpeciesApp.Worker, [arg1, arg2, arg3]),
      %{
        id: Cachex,
        start:
          {Cachex, :start_link,
           [
             :api_cache,
             [
                warmers: [
                  warmer(module: SpeciesApp.Species.Warmer)
                ],
                expiration:
                  expiration(
                    default:
                      :timer.seconds(31),
                    interval: :timer.seconds(30),
                    lazy: true
                  )
             ]
           ]}
      }
    ]

    ExternalService.start(
      :observations_fuse,
      # Tolerate 5 failures for every 1 second time window.
      fuse_strategy: {:standard, 5, 1_000},
      # Reset the fuse 5 seconds after it is blown.
      fuse_refresh: 5_000,
      # Limit to 100 calls per second.
      rate_limit: {100, 1_000}
    )

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SpeciesApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SpeciesAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
