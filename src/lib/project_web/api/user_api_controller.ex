defmodule ProjectWeb.UserApiController do
  use ProjectWeb, :controller

  alias Project.Accounts
  alias Project.Accounts.User

  def index(conn, params) do
    render(conn, "user_index.json", api_data: params)
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
