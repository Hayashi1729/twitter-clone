defmodule ProjectWeb.RedirectPlugTest do
  use ProjectWeb.ConnCase
  use ProjectWeb, :controller
  alias ProjectWeb.RedirectPlug

  import Project.Factory

  test "redirect if user is authenticated", %{conn: conn} do 
    user = insert(:user)
    conn =
      conn
      |> assign(:current_user, user)
      |> bypass_through(ProjectWeb.Router, :browser)
      |> get("/sessions/new")
      |> RedirectPlug.call(RedirectPlug.init([]))  

    assert redirected_to(conn, 302) == "/"
  end

  test "allow access if user is not authenticated", %{conn: conn} do
    conn =
      conn
      |> bypass_through(ProjectWeb.Router, :browser)
      |> get("/sessions/new")

    new_conn = RedirectPlug.call(conn, RedirectPlug.init([])) 
    assert new_conn == conn
  end
end