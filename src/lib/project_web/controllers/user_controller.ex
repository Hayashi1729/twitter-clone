defmodule ProjectWeb.UserController do
  use ProjectWeb, :controller

  alias Project.Twitter
  alias Project.Twitter.User

  plug :authenticate when action in [:index, :show]

  @doc """
  ユーザーの一覧を取得して表示。
  """
  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    users = Twitter.list_users()
    render(conn, "index.html", users: users)
  end

  @doc """
  新規ユーザー作成画面を表示。
  """
  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Twitter.change_registration(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  ユーザー作成処理を行う。
  """
  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"user" => user_params}) do
    case Twitter.register_user(user_params) do
      {:ok, user} ->
        conn
        |> ProjectWeb.Auth.login(user)
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @doc """
  ユーザー詳細表示画面を表示。
  """
  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    user = Twitter.get_user(id)
    render(conn, "show.html", user: user)
  end

  @doc """
  ユーザー情報編集画面を表示。
  """
  @spec edit(Plug.Conn.t(), map) :: Plug.Conn.t()
  def edit(conn, %{"id" => id}) do
    user = Twitter.get_user(id)
    changeset = Twitter.change_registration(user, %{})
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  @doc """
  ユーザー情報の更新処理を行う。
  """
  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Twitter.get_user(id)

    case Twitter.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  @doc """
  ユーザー情報を削除する処理を行う。
  """
  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    user = Twitter.get_user(id)
    {:ok, _user} = Twitter.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end

  @spec authenticate(Plug.Conn.t(), any) :: Plug.Conn.t()
  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
