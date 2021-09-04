defmodule TriWeb.UserControllerTest do
  use TriWeb.ConnCase

  import Tri.Factory

  @invalid_attrs %{display_name: "Erro", email: "mail.com", password: "1234"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: insert(:user)}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn, user: user} do
      params = params_for(:user)

      new_conn = post(conn, Routes.user_path(conn, :create), user: params)
      assert %{"id" => id} = json_response(new_conn, 201)["data"]

      conn =
        login(conn, user)
        |> get(Routes.user_path(conn, :show, id))


      map = %{
        "id" => id,
        "display_name" => params.display_name,
        "email" => params.email,
        "image" => params.image,
        "password" => params.password
      }
      assert map == json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert %{
        "display_name" => ["should be at least 8 character(s)"],
        "email" => ["invalid email format"],
        "password" => ["should be at least 6 character(s)"]
      } = json_response(conn, 400)["errors"]
    end
  end
end
