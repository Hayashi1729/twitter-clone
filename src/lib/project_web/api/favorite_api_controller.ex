defmodule ProjectWeb.FavoriteApiController do
  use ProjectWeb, :controller

  import Ecto.Query, warn: false

  alias Project.Twitter
  alias Project.Twitter.Favorite
  alias Project.Repo

  def index(conn, params) do
    render(conn, "favorite_index.json", api_data: params)
  end
end
