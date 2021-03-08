defmodule ProjectWeb.SessionController do
  use ProjectWeb, :controller

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
    case Project.Twitter.authenticate_by_username_and_pass(username, pass) do
      {:ok, user} ->
        conn
        |> ProjectWeb.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  @doc """
  ログアウト処理
  """
  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, _) do
    conn
    |> ProjectWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
