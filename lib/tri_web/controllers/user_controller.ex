defmodule TriWeb.UserController do
  use TriWeb, :controller

  alias Tri.Account
  alias Tri.Account.User
  alias Tri.Guardian

  action_fallback TriWeb.FallbackController

  def show(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def create(conn, user_params) do
    with {:ok, %User{} = user} <- Account.create_user(user_params),
      {:ok, token, _claims} = Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> json(%{token: token})
    end
  end
end
