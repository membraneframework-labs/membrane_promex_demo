defmodule MembranePromexDemo.Membrane.Pipeline do
  use Membrane.Pipeline

  alias Membrane.Testing
  alias MembranePromexDemo.Membrane.Filter

  @impl true
  def handle_init(_ctx, _options) do
    spec =
      child(:source, %Testing.Source{output: ["a", "b", "c"]})
      |> child(:filter, Filter)
      |> child(:sink, Testing.Sink)

    {[spec: spec], %{}}
  end
end
