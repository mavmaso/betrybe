defmodule TriWeb.UserController do
  use TriWeb, :controller

  alias Tri.Account
  alias Tri.Account.User

  action_fallback TriWeb.FallbackController

  def show(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end
end