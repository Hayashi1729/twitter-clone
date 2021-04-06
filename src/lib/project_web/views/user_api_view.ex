defmodule ProjectWeb.UserApiView do
  use ProjectWeb, :view

  def render("user_index.json", %{api_data: _params}) do
    Project.Accounts.list_users()
  end

  def render("user_show.json", %{user_id: id}) do
    Project.Accounts.get_user(id)
  end
end
