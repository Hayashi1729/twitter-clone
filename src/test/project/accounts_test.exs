defmodule Project.AccountsTest do
  use Project.DataCase, async: true

  import Project.Factory

  alias Project.Accounts
  alias Project.Accounts.User

  test "list_users" do
    user1 = insert(:user)
    assert [user1] == Accounts.list_users()
    user2 = insert(:user)
    assert [user1, user2] == Accounts.list_users()
  end

  test "get_user/1" do
    user = insert(:user)
    %{id: id} = user
    assert user == Accounts.get_user(id)
  end

  test "get_user_by/1" do
    user = insert(:user)
    %{username: name} = user
    assert user == Accounts.get_user_by(username: name)
  end

  test "update_user/2" do
    assert {:ok, user} = Accounts.register_user(params_for(:register_user))
    assert {:ok, user} = Accounts.update_user(user, %{username: "updated name"})
    assert user.username == "updated name"
  end

  test "delete_user/1" do
    user = insert(:user)
    assert {:ok, %User{}} = Accounts.delete_user(user)
    assert Accounts.list_users() == []
  end

  describe "register_user/1" do
    test "with valid data inserts user" do
      assert {:ok, %User{id: id}} = Accounts.register_user(params_for(:register_user))
      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "with invalid data does not insert user" do
      assert {:error, _changeset} = Accounts.register_user(params_for(:invalid_user))
      assert Accounts.list_users() == []
    end

    test "enforeces unique username" do
      attrs = Map.put(params_for(:register_user), :username, "Username")
      assert {:ok, %User{id: id}} = Accounts.register_user(attrs)
      attrs = Map.put(params_for(:register_user), :username, "Username")
      assert {:error, changeset} = Accounts.register_user(attrs)

      assert %{username: ["このユーザーネームは既に取得されています。"]} = errors_on(changeset)
      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "does not accept long usernames" do
      attrs = Map.put(params_for(:user), :username, String.duplicate("a", 100))
      {:error, changeset} = Accounts.register_user(attrs)

      assert %{username: ["ユーザーネームは20文字以下である必要があります。"]} = errors_on(changeset)
      assert Accounts.list_users() == []
    end

    test "requires password to be at least 6 chars long" do
      attrs = Map.put(params_for(:user), :password, "12345")
      {:error, changeset} = Accounts.register_user(attrs)

      assert %{password: ["パスワードは6文字以上100文字以下である必要があります。"]} = errors_on(changeset)
      assert Accounts.list_users() == []
    end
  end

  describe "authenticate_by_username_and_pass/2" do
    @pass "password"

    setup do
      attrs = Map.put(params_for(:user), :password, @pass)
      {:ok, user} = Accounts.register_user(attrs)
      {:ok, user: user}
    end

    test "returns user with correct password", %{user: user} do
      assert {:ok, auth_user} = Accounts.authenticate_by_username_and_pass(user.username, @pass)

      assert auth_user.id == user.id
    end

    test "returns unauthorized error with invalid password", %{user: user} do
      assert {:error, :unauthorized} =
               Accounts.authenticate_by_username_and_pass(user.username, "bad_password")
    end

    test "returns not found error with no matching user" do
      assert {:error, :user_not_found} =
               Accounts.authenticate_by_username_and_pass("unknown_user", @pass)
    end
  end
end
