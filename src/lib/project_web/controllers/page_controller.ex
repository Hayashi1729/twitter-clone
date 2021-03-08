defmodule ProjectWeb.PageController do
  use ProjectWeb, :controller

  @doc """
  メイン画面表示。
  """
  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
