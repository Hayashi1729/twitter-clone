defmodule ProjectWeb.PostController do
  use ProjectWeb, :controller

  alias Project.Twitter
  alias Project.Twitter.Post

  @doc """
  ツイートの一覧を取得して表示。
  """
  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    current_user = conn.assigns.current_user
    posts = Twitter.list_posts()
    posts_favorited_by_current_user = Twitter.list_posts_with_favorite(current_user.id)

    render(conn, "index.html",
      posts: posts,
      posts_favorited_by_current_user: posts_favorited_by_current_user
    )
  end

  @doc """
  新しいツイートの投稿画面を表示。
  """
  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
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
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
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
end
