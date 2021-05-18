defmodule ProjectWeb.PostApiController do
  use ProjectWeb, :controller

  alias Project.Twitter
  alias Project.Twitter.Post

  @doc """
  Render post_index.json
  """
  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    index = Twitter.list_posts()
    render(conn, "post_index.json", api_data: index)
  end

  @doc """
  Render posts_favorited_by_current_user.json
  """
  @spec favorited_post(Plug.Conn.t(), any) :: Plug.Conn.t()
  def favorited_post(conn, _params) do
    current_user = conn.assigns.current_user
    user_favorite = Twitter.list_posts_with_favorite(current_user.id)
    render(conn, "posts_favorited_by_current_user.json", api_data: user_favorite)
  end

  @doc """
  ツイート作成処理を行う。
  """
  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"post" => post_params}) do
    current_user = conn.assigns.current_user
    changeset = Ecto.build_assoc(current_user, :posts, post_params)

    case Twitter.create_post(changeset, post_params) do
      {:ok, %Post{} = post} ->
        get_post = Twitter.get_post!(post.id)

        conn
        |> put_status(:created)
        |> render("post_show.json", post: get_post)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ProjectWeb.ErrorView, "error.json", changeset: changeset)
    end
  end

  @doc """
  ツイート詳細表示画面を表示。
  """
  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    post = Twitter.get_post!(id)
    render(conn, "post_show.json", post: post)
  end

  @doc """
  ツイート更新処理を行う。
  """
  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Twitter.get_post!(id)

    case Twitter.update_post(post, post_params) do
      {:ok, %Post{} = post} ->
        conn
        |> put_status(:created)
        |> render("post_show.json", post: post)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ProjectWeb.ErrorView, "error.json", changeset: changeset)
    end
  end

  @doc """
  ツイート削除処理を行う。
  """
  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    post = Twitter.get_post!(id)

    case Twitter.delete_post(post) do
      {:ok, %Post{}} ->
        send_resp(conn, :no_content, "")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ProjectWeb.ErrorView, "error.json", changeset: changeset)
    end
  end
end
