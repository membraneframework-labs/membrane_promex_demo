defmodule MembranePromexDemo.Membrane.Filter do
  use Membrane.Filter

  def_input_pad(:input, accepted_format: _any)
  def_output_pad(:output, accepted_format: _any)

  @impl true
  def handle_buffer(_pad, buffer, _context, state) do
    :timer.sleep(Enum.random(100..500))
    {[buffer: {:output, buffer}], state}
  end
end
