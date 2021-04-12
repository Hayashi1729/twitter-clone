defmodule ProjectWeb.FavoriteApiView do
  use ProjectWeb, :view

  alias Project.Twitter

  def render("favorite_index.json", %{api_data: _params}) do
    Twitter.list_favorites()
  end
end
