defmodule ProjectWeb.PostViewTest do
  use ProjectWeb.ConnCase, async: true
  import Phoenix.View

  test "renders index.html", %{conn: conn} do 
    posts = [
      %Project.Twitter.Post{id: 1, tweet: "first_post", user_id: 1, user: %Project.Twitter.User{id: 1, username: "User1"}}, 
      %Project.Twitter.Post{id: 1, tweet: "second_post", user_id: 2, user: %Project.Twitter.User{id: 1, username: "User2"}}
    ]

    content = render_to_string(
      ProjectWeb.PostView, 
      "index.html", 
      conn: conn, 
      posts: posts)

    assert String.contains?(content, "ツイート一覧")

    for post <- posts do
      assert String.contains?(content, post.tweet)
    end
  end

  test "renders new.html", %{conn: conn} do 
    changeset = Project.Twitter.Post.changeset(%Project.Twitter.Post{})

    content =
      render_to_string(ProjectWeb.PostView, "new.html",
        conn: conn,
        changeset: changeset
      )

    assert String.contains?(content, "New Post")
  end

  test "renders show.html", %{conn: conn} do
    post = %Project.Twitter.Post{id: 1, tweet: "first_post", user_id: 1, user: %Project.Twitter.User{id: 1, username: "User1"}}
    
    content = render_to_string(ProjectWeb.PostView, "show.html",
        conn: conn,
        post: post
    )

    assert String.contains?(content, "Show Post")
  end
end