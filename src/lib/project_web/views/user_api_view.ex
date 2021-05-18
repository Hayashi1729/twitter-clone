defmodule ProjectWeb.UserApiView do
  use ProjectWeb, :view

  def render("user_index.json", %{api_data: list}) do
    render_many(list, ProjectWeb.UserApiView, "user.json")
  end

  def render("user_show.json", %{user: user}) do
    render_one(user, ProjectWeb.UserApiView, "user.json")
  end

  def render("user.json", user) do
    user.user_api
  end
end
