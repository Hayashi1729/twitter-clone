defmodule ProjectWeb.FavoriteView do
  use ProjectWeb, :view

  def render("favorite_show.json", %{favorite_id: fav}) do
    fav
  end
end
