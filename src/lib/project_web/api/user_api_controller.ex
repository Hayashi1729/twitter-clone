defmodule ProjectWeb.UserApiController do
  use ProjectWeb, :controller

  alias Project.Accounts
  alias Project.Accounts.User

  @doc """
  Render user_index.json
  """
  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, params) do
    render(conn, "user_index.json", api_data: params)
  end

  @doc """
  ユーザー作成処理を行う。
  """
  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("user_show.json", user_id: user.id)
    end
  end

  @doc """
  ユーザー表示処理を行う。
  """
  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    render(conn, "user_show.json", user_id: id)
  end

  @doc """
  ユーザー更新処理を行う。
  """
  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user(id)

    with {:ok, %User{}} <- Accounts.update_user(user, user_params) do
      render(conn, "user_show.json", user_id: user.id)
    end
  end

  @doc """
  ユーザー削除処理を行う。
  """
  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
