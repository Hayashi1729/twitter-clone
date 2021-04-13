defmodule ProjectWeb.UserController do
  use ProjectWeb, :controller

  alias Project.Accounts
  alias Project.Accounts.User

  @doc """
  ユーザーの一覧を取得して表示。
  """
  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  @doc """
  新規ユーザー作成画面を表示。
  """
  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    render(conn, "new.html")
  end

  @doc """
  ユーザー詳細表示画面を表示。
  """
  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    render(conn, "show.html", user: user)
  end

  @doc """
  ユーザー情報編集画面を表示。
  """
  @spec edit(Plug.Conn.t(), map) :: Plug.Conn.t()
  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    changeset = User.registration_changeset(user, %{})
    render(conn, "edit.html", user: user, changeset: changeset)
  end
end
