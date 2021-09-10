defmodule TriWeb.AuthPlug do
  use Guardian.Plug.Pipeline,
    otp_app: :tri,
    error_handler: Tri.Account.ErrorHandler,
    module: Tri.Guardian

  plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
