defmodule SpeciesApp.Auth.AuthAccessPipeline do
  @moduledoc false

  use Guardian.Plug.Pipeline,
    otp_app: :species_app,
    module: SpeciesApp.Auth.Guardian,
    error_handler: SpeciesApp.Auth.AuthErrorHandler

  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
  plug(SpeciesApp.Auth.Plug.CurrentUser)
end
