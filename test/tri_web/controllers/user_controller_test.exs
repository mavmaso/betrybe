defmodule TriWeb.UserControllerTest do
  use TriWeb.ConnCase, async: true

  import Tri.Factory

  @invalid_attrs %{display_name: "Erro", email: "mail.com", password: "1234"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: insert(:user)}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      params = params_for(:user)

      new_conn = post(conn, Routes.user_path(conn, :create), params)
      assert json_response(new_conn, 201)["token"] =~ "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9."
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), @invalid_attrs)
      assert %{
        "display_name" => ["should be at least 8 character(s)"],
        "email" => ["invalid email format"],
        "password" => ["should be at least 6 character(s)"]
      } = json_response(conn, 400)["errors"]
    end
  end

  describe "show user" do
    test "with valid params, renders :ok", %{conn: conn , user: user} do
      conn =
        login(conn, user)
        |> get(Routes.user_path(conn, :show, user.id))


      map = %{
        "id" => user.id,
        "display_name" => user.display_name,
        "email" => user.email,
        "image" => user.image,
        "password" => user.password
      }
      assert map == json_response(conn, 200)["data"]
    end
  end

  describe "delete user" do
    test "with valid data, renders :ok", %{conn: conn , user: user} do
      conn =
        login(conn, user)
        |> delete(Routes.user_path(conn, :delete))

      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  describe "index user" do
    test "with valid data, list users", %{conn: conn , user: user} do
      conn =
        login(conn, user)
        |> get(Routes.user_path(conn, :index))

      assert [_user] = json_response(conn, 200)["data"]
    end
  end
end
