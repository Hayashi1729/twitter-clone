defmodule ProjectWeb.UserApiController do
  use ProjectWeb, :controller

  alias Project.Accounts
  alias Project.Accounts.User

  @doc """
  Render user_index.json
  """
  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    list = Accounts.list_users()
    render(conn, "user_index.json", api_data: list)
  end

  @doc """
  ユーザー作成処理を行う。
  """
  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, %User{} = user} ->
        get_user = Accounts.get_user(user.id)

        conn
        |> ProjectWeb.AuthorizationPlug.login(user)
        |> put_status(:created)
        |> render("user_show.json", user: get_user)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ProjectWeb.ErrorView, "error.json", changeset: changeset)
    end
  end

  @doc """
  ユーザー表示処理を行う。
  """
  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    render(conn, "user_show.json", user: user)
  end

  @doc """
  ユーザー更新処理を行う。
  """
  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user(id)

    case Accounts.update_user(user, user_params) do
      {:ok, %User{} = user} ->
        get_user = Accounts.get_user(user.id)

        conn
        |> put_status(:created)
        |> render("user_show.json", user: get_user)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ProjectWeb.ErrorView, "error.json", changeset: changeset)
    end
  end

  @doc """
  ユーザー削除処理を行う。
  """
  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user(id)

    case Accounts.delete_user(user) do
      {:ok, %User{}} ->
        send_resp(conn, :no_content, "")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ProjectWeb.ErrorView, "error.json", changeset: changeset)
    end
  end
end
