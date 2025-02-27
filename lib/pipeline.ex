defmodule MembranePromexDemo.Pipeline do
  use GenServer

  alias Membrane.Testing
  import Membrane.ChildrenSpec
  require Logger

  import Telemetry.Metrics

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

    now = System.system_time(:second)
    {uptime_ms, _} = :erlang.statistics(:wall_clock)
    beam_start_time = now - div(uptime_ms, 1000)

    Telemetry.Metrics.ConsoleReporter.start_link(
      metrics:
        for handler <- [:handle_buffer, :handle_setup, :handle_init] do
          last_value([:membrane, :element, handler, :stop, :duration],
            description: "Duration of membrejn #{handler} callback",
            unit: {:native, :millisecond},
            tags: [:spanID, :traceID, :serviceName, :operationName, :parentSpanID, :startTime],
            tag_values: fn meta = %{callback_args: cb_args} ->
              b =
                case cb_args do
                  [_, b, _, _] -> b
                  [_, b] -> b
                end

              %{
                spanID: inspect(meta.component_path),
                traceID: inspect(beam_start_time),
                serviceName: inspect(meta.callback_context.name),
                operationName: inspect(handler),
                parentSpanID: "",
                startTime:
                  :erlang.convert_time_unit(
                    meta.monotonic_time + :erlang.time_offset(),
                    :native,
                    :millisecond
                  )
              }
            end
          )
        end
    )

    _pid = Testing.Pipeline.start(spec: child_spec)
    {:ok, stack}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
