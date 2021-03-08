defmodule ProjectWeb.PostController do
  use ProjectWeb, :controller

  alias Project.Twitter
  alias Project.Twitter.Post

  plug :authenticate when action in [:index, :show]

  @doc """
  ツイートの一覧を取得して表示。
  """
  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    posts = Twitter.list_posts()
    render(conn, "index.html", posts: posts)
  end
  
  @doc """
  新しいツイートの投稿画面を表示。
  """
  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Twitter.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  ツイート作成処理を行う。
  """
  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()  
  def create(conn, %{"post" => post_params}) do
    current_user = conn.assigns.current_user
    changeset = Ecto.build_assoc(current_user, :posts, post_params)
    case Twitter.create_post(changeset, post_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @doc """ 
  ツイート詳細表示画面を表示。
  """
  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    post = Twitter.get_post!(id)
    render(conn, "show.html", post: post)
  end

  @doc """
  ツイート編集画面表示。
  """
  @spec edit(Plug.Conn.t(), map) :: Plug.Conn.t()
  def edit(conn, %{"id" => id}) do
    post = Twitter.get_post!(id)
    changeset = Twitter.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  @doc """
  ツイートの更新処理を行う。
  """
  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Twitter.get_post!(id)

    case Twitter.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  @doc """
  ツイート削除処理を行う。
  """
  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    post = Twitter.get_post!(id)
    {:ok, _post} = Twitter.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
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
