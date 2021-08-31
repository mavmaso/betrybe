defmodule Tri.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :display_name, :string
    field :email, :string
    field :image, :string
    field :password, :string

    timestamps()
  end

  @required ~w(display_name email password)a

  @optional ~w(image)a

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @optional ++ @required)
    |> validate_required(@required)
    |> validate_length(:display_name, min: 8)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> validate_email()
  end

  defp validate_email(changeset) do
    validate_change(changeset, :email, fn _, email ->
      case Regex.run(~r/^[A-Za-z0-9._%+-+']+@[A-Za-z0-9.-]/, email) do
        nil -> [email: "invalid email format"]
        [_] -> []
      end
    end)
  end
end
