defmodule ProjectWeb.PostApiView do
  use ProjectWeb, :view

  def render("post_index.json", %{api_data: index}) do
    index
  end

  def render("posts_favorited_by_current_user.json", %{api_data: user_favorite}) do
    user_favorite
  end

  def render("post_show.json", %{post: post}) do
    post
  end
end
