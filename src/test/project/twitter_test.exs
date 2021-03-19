defmodule Project.TwitterTest do
  use Project.DataCase, async: true

  import Project.Factory

  alias Project.Twitter
  alias Project.Twitter.Post
  alias Project.Twitter.Favorite

  test "list_posts/0" do
    post1 =
      :post
      |> insert()
      |> Repo.preload(:favorites)

    assert [post1] == Twitter.list_posts()

    post2 =
      :post
      |> insert()
      |> Repo.preload(:favorites)

    assert [post1, post2] == Twitter.list_posts()
  end

  describe "get_post!/1" do
    test "preload User" do
      post = insert(:post)
      %{id: id} = post
      %{user: %{username: name}} = post
      post_test = Twitter.get_post!(id)
      assert name == post_test.user.username
    end
  end

  test "create_post/2 with valid data creates a post" do
    post = insert(:post)
    %{tweet: tweet} = post

    assert post.tweet == tweet
  end

  test "create_post/2 with invalid data returns error changeset" do
    post = insert(:post)

    assert {:error, %Ecto.Changeset{}} =
             Twitter.create_post(post, params_with_assocs(:invalid_post))
  end

  test "update_post with valid data updates the post" do
    post = insert(:post)
    assert {:ok, post} = Twitter.update_post(post, %{tweet: "updated tweet"})
    assert %Post{} = post
    assert post.tweet == "updated tweet"
  end

  test "update_post/2 with invalid data returns error changeset" do
    %Post{id: id} = post = insert(:post)

    assert {:error, %Ecto.Changeset{}} = Twitter.update_post(post, params_for(:invalid_post))

    assert %Post{id: ^id} = Twitter.get_post!(id)
  end

  test "delete_post deletes the post" do
    post = insert(:post)
    assert {:ok, %Post{}} = Twitter.delete_post(post)
    assert Twitter.list_posts() == []
  end

  test "create_favorite creates the favorite" do
    current_user = insert(:user)
    post = insert(:post)

    assert {:ok, %Favorite{}} = Twitter.create_favorite(post.id, current_user.id)
  end

  test "delete_favorite deletes the favorite" do
    favorite = insert(:favorite)

    assert {:ok, %Favorite{}} = Twitter.delete_favorite(favorite)
  end

  test "list_posts_with_favorite/1" do
    current_user = insert(:user)
    post1 = insert(:post)
    assert {:ok, %Favorite{}} = Twitter.create_favorite(post1.id, current_user.id)

    post2 = insert(:post)
    assert {:ok, %Favorite{}} = Twitter.create_favorite(post2.id, current_user.id)

    assert [post1.id, post2.id] == Twitter.list_posts_with_favorite(current_user.id)
  end

  test "list_favorite_posts/1" do
    current_user = insert(:user)
    post1 = insert(:post)
    assert {:ok, %Favorite{post_id: post_id1}} = Twitter.create_favorite(post1.id, current_user.id)

    post2 = insert(:post)
    assert {:ok, %Favorite{post_id: post_id2}} = Twitter.create_favorite(post2.id, current_user.id)

    assert [%Favorite{post_id: ^post_id1}, %Favorite{post_id: ^post_id2}] = Twitter.list_favorite_posts(current_user.id)
  end

  test "list_favorite_users/1" do
    post = insert(:post)
    current_user1 = insert(:user)
    assert {:ok, %Favorite{user_id: user_id1}} = Twitter.create_favorite(post.id, current_user1.id)

    current_user2 = insert(:user)
    assert {:ok, %Favorite{user_id: user_id2}} = Twitter.create_favorite(post.id, current_user2.id)

    assert [%Favorite{user_id: ^user_id1}, %Favorite{user_id: ^user_id2}] = Twitter.list_favorite_users(post.id)
  end
end
