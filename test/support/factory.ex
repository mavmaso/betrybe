defmodule Tri.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Tri.Repo

  use Tri.UserFactory
end
