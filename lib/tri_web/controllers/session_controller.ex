defmodule TriWeb.SessionController do
  use TriWeb, :controller

  alias Tri.Account
  alias Tri.Account.User

  action_fallback TriWeb.FallbackController

  def login(conn, params) do
    with {:ok, %User{}= user} <- Account.authenticate_user(params) do
      {:ok, token, _claims} = Tri.Guardian.encode_and_sign(user)

      json(conn, %{token: token})
    end
  end
end
