defmodule ProjectWeb.PageControllerTest do
  use ProjectWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "<index></index>"
  end
end
