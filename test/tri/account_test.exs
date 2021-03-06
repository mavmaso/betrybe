defmodule Tri.AccountTest do
  use Tri.DataCase, async: true

  alias Tri.Account

  import Tri.Factory

  describe "users" do
    alias Tri.Account.User

    @invalid_attrs %{display_name: "Erro", email: "mail.com", password: "1234"}

    test "list_users/0 returns all users" do
      user = insert(:user)
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user)
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      params = params_for(:user)

      assert {:ok, %User{} = user} = Account.create_user(params)
      assert user.display_name == params.display_name
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = insert(:user)
      params = %{email: "novo@mail.com"}

      assert {:ok, %User{} = user} = Account.update_user(user, params)
      assert user.display_name == user.display_name
      assert user.email == params.email
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert(:user)
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = insert(:user)
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end
end
