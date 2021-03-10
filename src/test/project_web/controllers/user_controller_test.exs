defmodule ProjectWeb.UserControllerTest do
  use ProjectWeb.ConnCase

  import Project.Factory

  describe "Logged-In User" do
    setup %{conn: conn} do
      {:ok, user} = Project.Accounts.register_user(params_for(:register_user))
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn, user: user}
    end

    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Users"
    end

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert redirected_to(conn) == Routes.user_path(conn, :index)
      assert redirected_to(conn, 302) == "/users"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: params_for(:register_user))

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == 
        Routes.user_path(conn, :show, id)

      conn = get conn, Routes.user_path(conn, :show, id)

      assert html_response(conn, 200) =~ "Show User"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: params_for(:invalid_user))
      assert html_response(conn, 200) =~ "New User"
    end
  end
end