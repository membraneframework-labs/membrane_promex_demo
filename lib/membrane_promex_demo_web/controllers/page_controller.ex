defmodule MembranePromexDemoWeb.PageController do
  use MembranePromexDemoWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    {:ok, _supervisor, _pid} = Membrane.Pipeline.start(MembranePromexDemo.Membrane.Pipeline)
    render(conn, :home, layout: false)
  end
end
