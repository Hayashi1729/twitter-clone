defmodule ProjectWeb.PostApiView do
  use ProjectWeb, :view

  def render("post_index.json", %{api_data: _params}) do
    Project.Twitter.list_posts()
  end
end
