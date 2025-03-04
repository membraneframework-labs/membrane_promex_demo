defmodule MembranePromexDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MembranePromexDemo.PromEx,
      MembranePromexDemoWeb.Telemetry,
      {DNSCluster,
       query: Application.get_env(:membrane_promex_demo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MembranePromexDemo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MembranePromexDemo.Finch},
      # Start a worker by calling: MembranePromexDemo.Worker.start_link(arg)
      # {MembranePromexDemo.Worker, arg},
      # Start to serve requests, typically the last entry
      MembranePromexDemoWeb.Endpoint,
      MembranePromexDemo.PipelineRunner
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MembranePromexDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MembranePromexDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
