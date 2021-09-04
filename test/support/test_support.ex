defmodule TriWeb.TestSupport do
  @moduledoc """
  Handles support functions for tests
  """
  import Plug.Conn

  alias Tri.Account.User
  alias Tri.Guardian

  @doc """
  Logs-in an user, requires an %User{}
  """
  @spec login(%Plug.Conn{}, %User{}) :: %Plug.Conn{}
  def login(conn, user) do
    {:ok, token, _c} = Guardian.encode_and_sign(user)

    conn
    |> put_req_header("authorization", "Bearer #{token}")
  end
end
