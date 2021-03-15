defmodule ProjectWeb.FavoriteController do
  use ProjectWeb, :controller
  
  import Ecto.Query, warn: false

  alias Project.Twitter
  alias Project.Twitter.Favorite
  alias Project.Repo

  @doc """
  お気に入り登録処理を行う。
  """
  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t() 
  def create(conn, %{"post_id" => post_id}) do
    current_user = conn.assigns.current_user
    post = Twitter.get_post!(post_id)

    case Twitter.create_favorite(post.id, current_user.id) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "お気に入り登録しました。")
        |> redirect(to: Routes.post_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "お気に入り登録できませんでした。")
        |> redirect(to: Routes.post_path(conn, :index))
    end
  end

  @doc """
  お気に入り登録解除処理を行う
  """
  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, %{"post_id" => post_id}) do
    current_user = conn.assigns.current_user
    query = from f in Favorite,
        where: f.post_id == ^post_id and f.user_id == ^current_user.id
    fav = Repo.one(query)
    Twitter.delete_favorite(fav)
    
    conn
    |> put_flash(:info, "お気に入り登録を解除しました。")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end