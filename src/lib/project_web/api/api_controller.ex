defmodule ProjectWeb.ApiController do
  use ProjectWeb, :controller

  def index(conn, params) do
    render(conn, "api.json", api_data: params)
  end
end
