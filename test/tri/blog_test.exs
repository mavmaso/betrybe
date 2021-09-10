defmodule Tri.BlogTest do
  use Tri.DataCase, async: true

  alias Tri.Blog

  import Tri.Factory

  describe "posts" do
    alias Tri.Blog.Post

    test "list_posts/0 returns all posts" do
      post = insert(:post)
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = insert(:post)
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      params = params_with_assocs(:post)

      assert {:ok, %Post{} = post} = Blog.create_post(params)
      assert post.title == params.title
    end

    test "create_post/1 with invalid data returns error changeset" do
      params = %{title: nil}

      assert {:error, %Ecto.Changeset{}} = Blog.create_post(params)
    end

    test "update_post/2 with valid data updates the post" do
      post = insert(:post)
      params = params_with_assocs(:post)

      assert {:ok, %Post{} = post} = Blog.update_post(post, params)
      assert post.title == params.title
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = insert(:post)
      params = %{content: nil}

      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, params)
    end

    test "delete_post/1 deletes the post" do
      post = insert(:post)

      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = insert(:post)

      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end
end
