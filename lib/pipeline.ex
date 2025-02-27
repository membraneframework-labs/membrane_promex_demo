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

    defmodule TestFilter do
      use Membrane.Filter

      def_input_pad(:input, accepted_format: _any)
      def_output_pad(:output, accepted_format: _any)

      @impl true
      def handle_buffer(_pad, buffer, _context, state) do
        :timer.sleep(Enum.random(100..500))
        {[buffer: {:output, buffer}], state}
      end
    end

    child_spec =
      child(:source, %Testing.Source{output: ["a", "b", "c"]})
      |> child(:filter, TestFilter)
      |> child(:sink, Testing.Sink)

    _pid = Testing.Pipeline.start(spec: child_spec)
    {:ok, stack}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
