defmodule Tri.PostFactory do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      def post_factory() do
        %Tri.Blog.Post{
          title: "titulo",
          content: "algo com mais algo dentro",
          user: build(:user)
        }
      end
    end
  end
end
