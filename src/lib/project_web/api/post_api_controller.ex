defmodule ProjectWeb.PostApiController do
  use ProjectWeb, :controller

  def index(conn, params) do
    render(conn, "post_index.json", api_data: params)
  end
end
