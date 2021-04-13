defmodule ProjectWeb.ApiController do
  use ProjectWeb, :controller

  @doc """
  Render api.json
  """
  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, params) do
    render(conn, "api.json", api_data: params)
  end
end
