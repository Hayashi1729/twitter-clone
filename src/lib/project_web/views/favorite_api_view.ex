defmodule ProjectWeb.FavoriteApiView do
  use ProjectWeb, :view

  def render("favorite_index.json", %{api_data: list}) do
    render_many(list, ProjectWeb.FavoriteApiView, "favorite.json")
  end

  def render("favorite.json", favorite) do
    favorite.favorite_api
  end
end
