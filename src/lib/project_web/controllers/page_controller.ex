defmodule ProjectWeb.PageController do
  use ProjectWeb, :controller

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  @doc """
  メイン画面表示。
  """
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
