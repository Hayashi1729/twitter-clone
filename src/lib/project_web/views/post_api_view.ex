defmodule ProjectWeb.PostApiView do
  use ProjectWeb, :view

  alias Project.Twitter

  def render("post_index.json", %{api_data: _params}) do
    Twitter.list_posts()
  end

  def render("posts_favorited_by_current_user.json", %{api_data: current_user}) do
    Twitter.list_posts_with_favorite(current_user.id)
  end

  def render("post_show.json", %{post_id: id}) do
    Twitter.get_post!(id)
  end
end
