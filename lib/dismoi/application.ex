defmodule Dismoi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # Run database migrations
    Dismoi.Release.migrate()

    children = [
      # Start the Telemetry supervisor
      DismoiWeb.Telemetry,
      # Start the Ecto repository
      Dismoi.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Dismoi.PubSub},
      # Start Finch
      {Finch, name: Dismoi.Finch},
      # Start the Endpoint (http/https)
      DismoiWeb.Endpoint
      # Start a worker by calling: Dismoi.Worker.start_link(arg)
      # {Dismoi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dismoi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DismoiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
