defmodule TriWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use TriWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(400)
    |> put_view(TriWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(TriWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:erro, :user_not_found}) do
    conn
    |> put_status(400)
    |> json(%{message: "Invalid params, can't login"})
  end

  def call(conn, {:error, :not_owner}) do
    conn
    |> put_status(400)
    |> json(%{message: "Not the owner"})
  end
end
