defmodule ProjectWeb.FavoriteApiController do
  use ProjectWeb, :controller

  import Ecto.Query, warn: false

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, params) do
    render(conn, "favorite_index.json", api_data: params)
  end
end
