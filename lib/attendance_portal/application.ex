defmodule AttendancePortal.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      AttendancePortal.Repo,
      # Start the Telemetry supervisor
      AttendancePortalWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: AttendancePortal.PubSub},
      # Start the Endpoint (http/https)
      AttendancePortalWeb.Endpoint
      # Start a worker by calling: AttendancePortal.Worker.start_link(arg)
      # {AttendancePortal.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AttendancePortal.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AttendancePortalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
