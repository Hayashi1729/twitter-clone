defmodule ProjectWeb.FavoriteApiController do
  use ProjectWeb, :controller

  import Ecto.Query, warn: false

  alias Project.Twitter
  alias Project.Twitter.Favorite
  alias Project.Repo

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
end
