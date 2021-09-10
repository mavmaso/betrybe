defmodule TriWeb.PostController do
  use TriWeb, :controller

  alias Tri.Blog
  alias Tri.Blog.Post

  action_fallback TriWeb.FallbackController

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => params}) do
    %{"sub" => sub} = Tri.Guardian.get_claims(conn)

    with {:ok, %Post{} = post} <- Blog.create_post(Map.merge(params, %{"user_id" => sub})) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    with {:ok, %Post{} = post} <- Blog.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    %{"sub" => user_id} = Tri.Guardian.get_claims(conn)

    with {:ok, :owner} <- Blog.ownership(post, user_id),
      {:ok, %Post{}} <- Blog.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
