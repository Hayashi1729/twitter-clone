defmodule ProjectWeb.AuthUserPlugTest do
  use ProjectWeb.ConnCase
  use ProjectWeb, :controller
  alias ProjectWeb.AuthUserPlug

  import Project.Factory

  test "allow access if user is authenticated", %{conn: conn} do 
    user = insert(:user)
    conn =
      conn
      |> assign(:current_user, user)
      |> bypass_through(ProjectWeb.Router, :browser)
      |> get("/posts")
    new_conn = AuthUserPlug.call(conn, AuthUserPlug.init([]))
      
    assert new_conn == conn
  end

  test "redirect if user is not authenticated", %{conn: conn} do 
    conn =
      conn
      |> bypass_through(ProjectWeb.Router, :browser)
      |> get("/posts")
      |> AuthUserPlug.call(AuthUserPlug.init([]))  
      
    assert redirected_to(conn, 302) == "/"
  end
end