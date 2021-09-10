defmodule Tri.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :content, :string

    belongs_to :user, Tri.Account.User

    timestamps()
  end

  @required ~w(title content user_id)a

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
