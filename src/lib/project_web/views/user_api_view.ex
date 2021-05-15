defmodule ProjectWeb.UserApiView do
  use ProjectWeb, :view

  def render("user_index.json", %{api_data: list}) do
    list
  end

  def render("user_show.json", %{user: user}) do
    user
  end
end
