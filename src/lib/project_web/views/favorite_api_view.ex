defmodule ProjectWeb.FavoriteApiView do
  use ProjectWeb, :view

  def render("favorite_index.json", %{api_data: list}) do
    list
  end
end
