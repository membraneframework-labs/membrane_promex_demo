defmodule MembranePromexDemo.PromEx do
  use PromEx, otp_app: :membrane_promex_demo

  @impl true
  def plugins do
    [
      Membrane.PromEx
    ]
  end
end
