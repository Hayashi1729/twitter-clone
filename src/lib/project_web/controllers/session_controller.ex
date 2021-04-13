defmodule ProjectWeb.SessionController do
  use ProjectWeb, :controller

  alias Project.Accounts
  alias Project.Accounts.User

  @doc """
  ログイン画面表示
  """
  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _) do
    render(conn, "new.html")
  end

  @doc """
  ログイン処理
  """
  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(
        conn,
        %{"session" => %{"username" => username, "password" => pass}}
      ) do
    case Accounts.authenticate_by_username_and_pass(username, pass) do
      {:ok, %User{} = user} ->
        conn
        |> ProjectWeb.AuthorizationPlug.login(user)
        |> send_resp(200, "ok")

      {:error, _} ->
        IO.inspect(username)
    end
  end

  @doc """
  ログアウト処理
  """
  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, _) do
    conn
    |> ProjectWeb.AuthorizationPlug.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
