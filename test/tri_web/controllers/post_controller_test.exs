defmodule TriWeb.PostControllerTest do
  use TriWeb.ConnCase, async: true

  alias Tri.Blog

  import Tri.Factory

  @update_attrs %{
    title: "some updated title"
  }
  @invalid_attrs %{title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: insert(:user)}
  end

  describe "index" do
    test "lists all posts", %{conn: conn, user: user} do
      conn =
        login(conn, user)
        |> get(Routes.post_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create post" do
    test "renders post when data is valid", %{conn: conn, user: user} do
      params = params_for(:post)

      conn =
        login(conn, user)
        |> post(Routes.post_path(conn, :create), post: params)
      assert %{"id" => id} = json_response(conn, 201)["data"]
      assert %{
               "id" => ^id,
               "title" => "titulo",
             } = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn =
        login(conn, user)
        |> post(Routes.post_path(conn, :create), post: @invalid_attrs)

      assert json_response(conn, 400)["errors"] != %{}
    end
  end

  describe "update post" do
    setup [:create_post]

    test "renders post when valid data", %{conn: conn, user: user} do
      post = insert(:post, %{user: user})
      %{id: id} = post

      conn =
        login(conn, user)
        |> put(Routes.post_path(conn, :update, post), post: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]
      assert %{"title" => "some updated title"} = json_response(conn, 200)["data"]
    end

    test "renders :error when not the owner", %{conn: conn, post: post, user: user} do
      conn =
        login(conn, user)
        |> put(Routes.post_path(conn, :update, post), post: @update_attrs)

      assert "Not the owner" = json_response(conn, 400)["message"]
    end

    test "renders errors when data is invalid", %{conn: conn, post: post, user: user} do
      conn =
        login(conn, user)
        |> put(Routes.post_path(conn, :update, post), post: @invalid_attrs)
      assert json_response(conn, 400)["errors"] != %{}
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "renders errors when not the post's owner", %{conn: conn, post: post, user: user} do
      conn =
        login(conn, user)
        |> delete(Routes.post_path(conn, :delete, post))

      assert response(conn, 400)
    end

    test "renders ok when data is valid", %{conn: conn, user: user} do
      post = insert(:post, %{user: user})

      conn =
        login(conn, user)
        |> delete(Routes.post_path(conn, :delete, post))

      assert response(conn, 204)
      assert_raise Ecto.NoResultsError, fn ->
        Blog.get_post!(post.id)
      end
    end
  end

  describe "search" do
    setup [:create_post]

    test "renders a list of results when term is found", %{conn: conn, user: user} do
      post_A = insert(:post, %{content: "term"})
      post_B = insert(:post, %{title: "term"})

      conn =
        login(conn, user)
        |> get("/post/search?q=term")

      assert subject = json_response(conn, 200)["data"]
      assert length(subject) == 2
      assert Enum.all?(subject, fn x -> x["id"] in [post_A.id, post_B.id] end)
    end
  end

  defp create_post(_) do
    %{post: insert(:post)}
  end
end
