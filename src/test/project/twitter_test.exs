defmodule Project.TwitterTest do
  use Project.DataCase, async: true

  alias Project.Twitter
  alias Project.Twitter.Post
  alias Project.Accounts

  @valid_attrs %{tweet: "tweet", user_id: 10, user: %Project.Accounts.User{username: "Alice", id: 10}}
  @invalid_attrs %{tweet: nil, user_id: nil, user: %Project.Accounts.User{username: nil, id: nil}}

  test "list_posts/0" do
    post1 = %Twitter.Post{id: 1, tweet: "some_text", user_id: 10, user: %Accounts.User{username: "Alice", id: 10}}
    Repo.insert(post1)
    assert [post1] = Twitter.list_posts()
    post2 = %Twitter.Post{id: 2, tweet: "another_text", user_id: 11, user: %Accounts.User{username: "Bob", id: 11}}
    Repo.insert(post2)
    assert [post1, post2] = Twitter.list_posts()
  end

  describe "get_post!/1" do
    test "preload User" do
      post = %Post{
        id: 4,
        tweet: "some_text",
        user_id: 10,
        user: %Project.Accounts.User{
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
end
