defmodule TriWeb.PostView do
  use TriWeb, :view
  alias TriWeb.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    post = Tri.Repo.preload(post, [:user])

    %{
      id: post.id,
      title: post.title,
      content: post.content,
      user: TriWeb.UserView.render("user.json", user: post.user)
    }
  end
end
