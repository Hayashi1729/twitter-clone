defmodule Project.AccountsTest do
  use Project.DataCase, async: true

  alias Project.Accounts
  alias Project.Accounts.User

  @valid_attrs %{tweet: "tweet", user_id: 10, user: %Project.Accounts.User{username: "Alice", id: 10}}
  @invalid_attrs %{tweet: nil, user_id: nil, user: %Project.Accounts.User{username: nil, id: nil}}

  test "change_user/1 returns a user changese" do
    user = user_fixture()
    assert %Ecto.Changeset{} = User.registration_changeset(user, %{}) 
  end

  test "list_users" do
    %User{id: id1} = user_fixture()
    assert [%User{id: ^id1}] = Accounts.list_users()
    %User{id: id2} = user_fixture()
    assert [%User{id: ^id1}, %User{id: ^id2}] = Accounts.list_users()
  end

  test "get_user/1" do
    %User{id: id} = user_fixture()
    assert %User{id: ^id} = Accounts.get_user(id)
  end

  @user %{username: "Alice", password: "asecret"}
  test "get_user_by/1" do
    user_fixture(@user)
    assert %User{} = Accounts.get_user_by(username: "Alice")
  end

  test "update_user/2" do
    user = user_fixture()
    assert {:ok, user} = 
      Accounts.update_user(user, %{username: "updated name"})
    assert %User{} = user
    assert user.username == "updated name"
  end

  test "delete_user/1" do
    user = user_fixture()
    assert {:ok, %User{}} = Accounts.delete_user(user)
    assert Accounts.list_users() == []
  end

  describe "register_user/1" do
    @valid_attrs %{
      username: "Alice",
      password: "asecret"
    }
    @invalid_attrs %{}

    test "with valid data inserts user" do
      assert {:ok, %User{id: id} = user} = Accounts.register_user(@valid_attrs)
      assert user.username == "Alice"
      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "with invalid data does not insert user" do
      assert {:error, _changeset} = Accounts.register_user(@invalid_attrs)
      assert Accounts.list_users() == []
    end

    test "enforeces unique username" do
      assert {:ok, %User{id: id}} = Accounts.register_user(@valid_attrs)
      assert {:error, changeset} = Accounts.register_user(@valid_attrs)

      assert %{username: ["このユーザーネームは既に取得されています。"]} = errors_on(changeset)
      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "does not accept long usernames" do
      attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 100))
      {:error, changeset} = Accounts.register_user(attrs)

      assert %{username: ["ユーザーネームは20文字以下である必要があります。"]} =
             errors_on(changeset)
      assert Accounts.list_users() == []
    end

    test "requires password to be at least 6 chars long" do
      attrs = Map.put(@valid_attrs, :password, "12345")
      {:error, changeset} = Accounts.register_user(attrs)

      assert %{password: ["パスワードは6文字以上100文字以下である必要があります。"]} =
         errors_on(changeset)
      assert Accounts.list_users() == []
    end
  end

  describe "authenticate_by_username_and_pass/2" do
    @pass "asecret"

    setup do
      {:ok, user: user_fixture(password: @pass)}
    end

    test "returns user with correct password", %{user: user} do
      assert {:ok, auth_user} =
             Accounts.authenticate_by_username_and_pass(user.username, @pass)

      assert auth_user.id == user.id
    end

    test "returns unauthorized error with invalid password", %{user: user} do
      assert {:error, :unauthorized} =
          Accounts.authenticate_by_username_and_pass(user.username, "bad_password")
    end

    test "returns not found error with no matching user" do
      assert {:error, :not_found} =
             Accounts.authenticate_by_username_and_pass("unknown_user", @pass)
    end
  end
end
