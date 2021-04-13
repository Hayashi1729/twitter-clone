defmodule ProjectWeb.PostViewTest do
  use ProjectWeb.ConnCase, async: true
  import Phoenix.View
  import Project.Factory
  alias Project.Repo

  test "renders index.html", %{conn: conn} do
    post1 = :post |> insert() |> Repo.preload(:favorites)
    post2 = :post |> insert() |> Repo.preload(:favorites)
    current_user = %Project.Accounts.User{id: 10, username: "User"}
    posts = [post1, post2]
    posts_favorited_by_current_user = Project.Twitter.list_posts_with_favorite(current_user.id)

    content =
      render_to_string(
        ProjectWeb.PostView,
        "index.html",
        conn: conn,
        posts: posts,
        current_user: current_user,
        posts_favorited_by_current_user: posts_favorited_by_current_user
      )

    assert String.contains?(content, "post-index")

    # for post <- posts do
    #  assert String.contains?(content, post.tweet)
    # end
  end

  test "renders new.html", %{conn: conn} do
    changeset = Project.Twitter.Post.changeset(%Project.Twitter.Post{})

    content =
      render_to_string(ProjectWeb.PostView, "new.html",
        conn: conn,
        changeset: changeset
      )

    assert String.contains?(content, "post-new")
  end

  test "renders show.html", %{conn: conn} do
    post = %Project.Twitter.Post{
      id: 1,
      tweet: "first_post",
      user_id: 1,
      user: %Project.Accounts.User{id: 1, username: "User1"}
    }

    content =
      render_to_string(ProjectWeb.PostView, "show.html",
        conn: conn,
        post: post
      )

    assert String.contains?(content, "post-show")
  end
end
