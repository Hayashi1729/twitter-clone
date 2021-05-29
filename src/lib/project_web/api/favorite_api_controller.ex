defmodule ProjectWeb.FavoriteApiController do
  use ProjectWeb, :controller
  alias Project.Twitter

  import Ecto.Query, warn: false

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    list = Twitter.list_favorites()
    render(conn, "favorite_index.json", api_data: list)
  end
end
