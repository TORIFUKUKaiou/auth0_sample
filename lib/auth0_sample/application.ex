defmodule Auth0Sample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Auth0Sample.Repo,
      # Start the Telemetry supervisor
      Auth0SampleWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Auth0Sample.PubSub},
      # Start the Endpoint (http/https)
      Auth0SampleWeb.Endpoint
      # Start a worker by calling: Auth0Sample.Worker.start_link(arg)
      # {Auth0Sample.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Auth0Sample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Auth0SampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
