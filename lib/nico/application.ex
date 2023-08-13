defmodule Nico.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      NicoWeb.Telemetry,
      # Start the Ecto repository
      Nico.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Nico.PubSub},
      # Start Finch
      {Finch, name: Nico.Finch},
      # Start the Endpoint (http/https)
      NicoWeb.Endpoint
      # Start a worker by calling: Nico.Worker.start_link(arg)
      # {Nico.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Nico.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NicoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
