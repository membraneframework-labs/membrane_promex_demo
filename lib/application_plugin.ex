defmodule MembranePromexDemo.ApplicationPlugin do
  require Logger
  use PromEx.Plugin

  @impl true
  def manual_metrics(opts) do
    otp_app = Keyword.fetch!(opts, :otp_app)
    apps = Keyword.get(opts, :deps, :all)

    Manual.build(
      :application_versions_manual_metrics,
      {__MODULE__, :apps_running, [otp_app, apps]},
      [
        # Capture information regarding the primary application (i.e the user's application)
        last_value(
          [otp_app | [:application, :primary, :info]],
          event_name: [otp_app | [:application, :primary, :info]],
          description: "Information regarding the primary application. MMMM",
          measurement: :status,
          tags: [:name, :version, :modules]
        )

        # Additional metrics here
      ]
    )
  end

  @doc false
  def apps_running(otp_app, _apps) do
    Logger.info("Executing primary app metrics for #{otp_app}")
    # Emit primary app details
    :telemetry.execute(
      [otp_app | [:application, :primary, :info]],
      %{
        status: 1
      },
      %{}
    )
  end
end
