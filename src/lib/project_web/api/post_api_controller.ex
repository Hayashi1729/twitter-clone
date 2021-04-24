defmodule ProjectWeb.PostApiController do
  use ProjectWeb, :controller

  alias Project.Twitter
  alias Project.Twitter.Post

  @doc """
  Render post_index.json
  """
  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, params) do
    render(conn, "post_index.json", api_data: params)
  end

  @doc """
  Render posts_favorited_by_current_user.json
  """
  @spec favorited_post(Plug.Conn.t(), any) :: Plug.Conn.t()
  def favorited_post(conn, _params) do
    current_user = conn.assigns.current_user
    render(conn, "posts_favorited_by_current_user.json", api_data: current_user)
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
        conn
        |> put_status(:created)
        |> render("post_show.json", post_id: post.id)

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
    render(conn, "post_show.json", post_id: id)
  end

  @doc """
  ツイート更新処理を行う。
  """
  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Twitter.get_post!(id)

    case Twitter.update_post(post, post_params) do
      {:ok, %Post{}} ->
        conn
        |> put_status(:created)
        |> render("post_show.json", post_id: post.id)

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
    end
  end
end
