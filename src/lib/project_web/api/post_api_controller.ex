defmodule ProjectWeb.PostApiController do
  use ProjectWeb, :controller

  alias Project.Twitter
  alias Project.Twitter.Post

  def index(conn, params) do
    render(conn, "post_index.json", api_data: params)
  end

  def favorited_post(conn, _params) do
    current_user = conn.assigns.current_user
    render(conn, "posts_favorited_by_current_user.json", api_data: current_user)
  end

  def create(conn, %{"post" => post_params}) do
    current_user = conn.assigns.current_user
    changeset = Ecto.build_assoc(current_user, :posts, post_params)

    with {:ok, %Post{} = post} <- Twitter.create_post(changeset, post_params) do
      conn
      |> put_status(:created)
      |> render("post_show.json", post_id: post.id)
    end
  end

  @doc """
  ツイート詳細表示画面を表示。
  """
  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    render(conn, "post_show.json", post_id: id)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Twitter.get_post!(id)

    with {:ok, %Post{}} <- Twitter.update_post(post, post_params) do
      send_resp(conn, 200, "ok")
    end
  end

  @doc """
  ツイート削除処理を行う。
  """
  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    post = Twitter.get_post!(id)

    with {:ok, %Post{}} <- Twitter.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
