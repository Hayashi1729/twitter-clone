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
      {:ok, %Favorite{} = favorite} ->
        fav = Twitter.get_favorite!(favorite.id)

        conn
        |> put_status(:created)
        |> render("favorite_show.json", favorite_id: fav)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ProjectWeb.ErrorView, "error.json", changeset: changeset)
    end
  end

  @doc """
  お気に入り登録解除処理を行う
  """
  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, %{"post_id" => post_id}) do
    current_user = conn.assigns.current_user

    post =
      Favorite
      |> where([f], f.post_id == ^post_id and f.user_id == ^current_user.id)
      |> Repo.one()

    if post do
      case Twitter.delete_favorite(post) do
        {:ok, %Favorite{}} ->
          send_resp(conn, :no_content, "")

        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(ProjectWeb.ErrorView, "error.json", changeset: changeset)
      end
    else
      status = :favorite_not_found

      conn
      |> put_status(:unprocessable_entity)
      |> render(ProjectWeb.ErrorView, "error.json", status: status)
    end
  end
end
