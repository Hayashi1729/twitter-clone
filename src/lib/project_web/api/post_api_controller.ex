defmodule ProjectWeb.PostApiController do
  use ProjectWeb, :controller

  def index(conn, params) do
    render(conn, "post_index.json", api_data: params)
  end

  def favorited_post(conn, _params) do
    current_user = conn.assigns.current_user
    render(conn, "posts_favorited_by_current_user.json", api_data: current_user)
  end
end
