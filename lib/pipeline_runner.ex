defmodule MembranePromexDemo.PipelineRunner do
  use GenServer

  alias MembranePromexDemo.Membrane.Pipeline

  require Logger

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  ## Callbacks

  @impl true
  def init(stack) do
    Logger.info("Starting Membrane pipeline")

    {:ok, _supervisor, _pid} = Membrane.Pipeline.start(Pipeline)
    {:ok, stack}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
