defmodule Project.TwitterTest do
  use Project.DataCase, async: true

  alias Project.Twitter
  alias Project.Twitter.Post
  alias Project.Twitter.User

  @valid_attrs %{tweet: "tweet", user_id: 10, user: %Project.Twitter.User{username: "Alice", id: 10}}
  @invalid_attrs %{tweet: nil, user_id: nil, user: %Project.Twitter.User{username: nil, id: nil}}

  test "list_posts/0" do
      post1 = %Twitter.Post{id: 1, tweet: "some_text", user_id: 10, user: %Twitter.User{username: "Alice", id: 10}}
      Repo.insert(post1)
      assert [post1] = Twitter.list_posts()
      post2 = %Twitter.Post{id: 2, tweet: "another_text", user_id: 11, user: %Twitter.User{username: "Bob", id: 11}}
      Repo.insert(post2)
      assert [post1, post2] = Twitter.list_posts()
  end

  describe "get_post!/1" do
    test "preload User" do
      post = %Post{
        id: 4,
        tweet: "some_text",
        user_id: 10,
        user: %Project.Twitter.User{
          username: "Alice",
          id: 10
        }
      }
      Repo.insert(post)

      post_test = Twitter.get_post!(4)
      assert "Alice" = post_test.user.username
    end
  end

  test "create_post/2 with valid data creates a post" do
    post = post_fixture(@valid_attrs)    
         
    assert post.tweet == "tweet"
  end

  test "create_post/2 with invalid data returns error changeset" do 
    post = post_fixture()
    assert {:error, %Ecto.Changeset{}} = 
      Twitter.create_post(post, @invalid_attrs)
  end


  test "update_post with valid data updates the post" do
    post = post_fixture()
    assert {:ok, post} = 
      Twitter.update_post(post, %{tweet: "updated tweet"})
    assert %Post{} = post
    assert post.tweet == "updated tweet"
  end

  test "update_post/2 with invalid data returns error changeset" do 
    %Post{id: id} = post = post_fixture()
    
    assert {:error, %Ecto.Changeset{}} = 
      Twitter.update_post(post, @invalid_attrs)
      
    assert %Post{id: ^id} = Twitter.get_post!(id)
  end

  test "delete_post deletes the post" do
    post = post_fixture()
    assert {:ok, %Post{}} = Twitter.delete_post(post)
    assert Twitter.list_posts() == []
  end

  test "change_user/1 returns a post changese" do
    post = post_fixture()
    assert %Ecto.Changeset{} = Post.changeset(post) 
  end

  test "list_users" do
    %User{id: id1} = user_fixture()
    assert [%User{id: ^id1}] = Twitter.list_users()
    %User{id: id2} = user_fixture()
    assert [%User{id: ^id1}, %User{id: ^id2}] = Twitter.list_users()
  end

  test "get_user/1" do
    %User{id: id} = user_fixture()
    assert %User{id: ^id} = Twitter.get_user(id)
  end

  @user %{username: "Alice", password: "asecret"}
  test "get_user_by/1" do
    user_fixture(@user)
    assert %User{} = Twitter.get_user_by(username: "Alice")
  end

  test "update_user/2" do
    user = user_fixture()
    assert {:ok, user} = 
      Twitter.update_user(user, %{username: "updated name"})
    assert %User{} = user
    assert user.username == "updated name"
  end

  test "delete_user/1" do
    user = user_fixture()
    assert {:ok, %User{}} = Twitter.delete_user(user)
    assert Twitter.list_users() == []
  end

  describe "register_user/1" do
    @valid_attrs %{
      username: "Alice",
      password: "asecret"
    }
    @invalid_attrs %{}

    test "with valid data inserts user" do
      assert {:ok, %User{id: id} = user} = Twitter.register_user(@valid_attrs)
      assert user.username == "Alice"
      assert [%User{id: ^id}] = Twitter.list_users()
    end

    test "with invalid data does not insert user" do
      assert {:error, _changeset} = Twitter.register_user(@invalid_attrs)
      assert Twitter.list_users() == []
    end

    test "enforeces unique username" do
      assert {:ok, %User{id: id}} = Twitter.register_user(@valid_attrs)
      assert {:error, changeset} = Twitter.register_user(@valid_attrs)

      assert %{username: ["このユーザーネームは既に取得されています。"]} = errors_on(changeset)
      assert [%User{id: ^id}] = Twitter.list_users()
    end

    test "does not accept long usernames" do
      attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 100))
      {:error, changeset} = Twitter.register_user(attrs)

      assert %{username: ["ユーザーネームは20文字以下である必要があります。"]} =
             errors_on(changeset)
      assert Twitter.list_users() == []
    end

    test "requires password to be at least 6 chars long" do
      attrs = Map.put(@valid_attrs, :password, "12345")
      {:error, changeset} = Twitter.register_user(attrs)

      assert %{password: ["パスワードは6文字以上100文字以下である必要があります。"]} =
         errors_on(changeset)
      assert Twitter.list_users() == []
    end
  end

  describe "authenticate_by_username_and_pass/2" do
    @pass "asecret"

    setup do
      {:ok, user: user_fixture(password: @pass)}
    end

    test "returns user with correct password", %{user: user} do
      assert {:ok, auth_user} =
             Twitter.authenticate_by_username_and_pass(user.username, @pass)

      assert auth_user.id == user.id
    end

    test "returns unauthorized error with invalid password", %{user: user} do
      assert {:error, :unauthorized} =
          Twitter.authenticate_by_username_and_pass(user.username, "bad_password")
    end

    test "returns not found error with no matching user" do
      assert {:error, :not_found} =
             Twitter.authenticate_by_username_and_pass("unknown_user", @pass)
    end
  end
end
