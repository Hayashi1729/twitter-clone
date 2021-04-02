defmodule ProjectWeb.UserApiController do
  use ProjectWeb, :controller

  def index(conn, params) do
    render(conn, "user_index.json", api_data: params)
  end
end
