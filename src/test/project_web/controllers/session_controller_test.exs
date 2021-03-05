defmodule ProjectWeb.SessionControllerTest do
  use ProjectWeb.ConnCase

  test "login", %{conn: conn} do
    conn = get(conn, Routes.session_path(conn, :new))
    assert html_response(conn, 200) =~ "Login"
  end
end
