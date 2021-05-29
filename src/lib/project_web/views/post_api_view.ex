defmodule ProjectWeb.PostApiView do
  use ProjectWeb, :view

  def render("post_index.json", %{api_data: list}) do
    render_many(list, ProjectWeb.PostApiView, "post.json")
  end

  def render("post_show.json", %{post: post}) do
    render_one(post, ProjectWeb.PostApiView, "post.json")
  end

  def render("post.json", %{post_api: post}) do
    %{
      favorites: post.favorites,
      id: post.id,
      inserted_at: post.inserted_at,
      tweet: post.tweet,
      user: %{
        id: post.user.id,
        username: post.user.username
      },
      user_id: post.user_id
    }
  end

  def render("posts_favorited_by_current_user.json", %{api_data: user_favorite}) do
    render_many(user_favorite, ProjectWeb.PostApiView, "user_favorite.json")
  end

  def render("user_favorite.json", %{post_api: id}) do
    id
  end
end
