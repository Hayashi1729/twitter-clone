defmodule ProjectWeb.UserApiController do
  use ProjectWeb, :controller

  alias Project.Accounts
  alias Project.Accounts.User

  def index(conn, params) do
    render(conn, "user_index.json", api_data: params)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("user_show.json", user_id: user.id)
    end
  end

  def show(conn, %{"id" => id}) do
    render(conn, "user_show.json", user_id: id)
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
