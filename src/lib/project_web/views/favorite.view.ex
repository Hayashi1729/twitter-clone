defmodule ProjectWeb.FavoriteView do
  use ProjectWeb, :view

  alias Project.Twitter

  def render("favorite_show.json", %{favorite_id: id}) do
    Twitter.get_favorite!(id)
  end
end
