defmodule ProjectWeb.UserApiView do
  use ProjectWeb, :view

  def render("user_index.json", %{api_data: _params}) do
    Project.Accounts.list_users()
  end
end
