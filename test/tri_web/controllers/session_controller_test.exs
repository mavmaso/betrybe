defmodule TriWeb.SessionControllerTest do
  use TriWeb.ConnCase

  import Tri.Factory

  setup %{conn: conn} do
    user = insert(:user)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user}
  end

  describe "login" do
    test "with valid params, returns :ok", %{conn: conn, user: user} do
      params = %{email: user.email, password: user.password}

      conn = post(conn, Routes.session_path(conn, :login), params)

      assert json_response(conn, 200)["token"] =~ "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9."
    end

    test "with invalid params, returns :error", %{conn: conn, user: user} do
      params = %{email: user.email, password: "1234567"}

      conn = post(conn, Routes.session_path(conn, :login), params)

      assert %{"message" => "Invalid params, can't login"} == json_response(conn, 400)
    end
  end
end
