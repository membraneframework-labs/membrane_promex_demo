defmodule MembranePromexDemo.Pipeline do
  use GenServer

  alias Membrane.Testing
  import Membrane.ChildrenSpec
  require Logger

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  ## Callbacks

  @impl true
  def init(stack) do
    Logger.info("Starting Membrane pipeline")

    child_spec =
      child(:source, %Testing.Source{output: ["a", "b", "c"]})
      |> child(:filter, TestFilter)
      |> child(:sink, Testing.Sink)

    {:ok, _supervisor, _pid} = Testing.Pipeline.start(spec: child_spec)
    {:ok, stack}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
