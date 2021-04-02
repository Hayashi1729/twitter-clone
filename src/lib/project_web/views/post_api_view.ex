defmodule ProjectWeb.PostApiView do
  use ProjectWeb, :view

  def render("post_index.json", %{api_data: _params}) do
    Project.Twitter.list_posts()
  end

  def render("posts_favorited_by_current_user.json", %{api_data: current_user}) do
    Project.Twitter.list_posts_with_favorite(current_user.id)
  end
end
