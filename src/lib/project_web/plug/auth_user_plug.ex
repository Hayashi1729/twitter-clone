defmodule ProjectWeb.AuthUserPlug do
  import Plug.Conn
  
  use ProjectWeb, :controller

  @spec init(Plug.opts) :: Plug.opts
  def init(opts), do: opts

  def call(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end