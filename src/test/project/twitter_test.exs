defmodule Project.TwitterTest do
  use Project.DataCase, async: true

  import Project.Factory

  alias Project.Twitter
  alias Project.Twitter.Post

  test "list_posts/0" do
    post1 = insert(:post)
    assert [post1] == Twitter.list_posts()
    post2 = insert(:post)
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
    assert {:ok, post} = 
      Twitter.update_post(post, %{tweet: "updated tweet"})
    assert %Post{} = post
    assert post.tweet == "updated tweet"
  end

  test "update_post/2 with invalid data returns error changeset" do 
    %Post{id: id} = post = insert(:post)
    
    assert {:error, %Ecto.Changeset{}} = 
      Twitter.update_post(post, params_for(:invalid_post))
      
    assert %Post{id: ^id} = Twitter.get_post!(id)
  end

  test "delete_post deletes the post" do
    post = insert(:post)
    assert {:ok, %Post{}} = Twitter.delete_post(post)
    assert Twitter.list_posts() == []
  end
end
