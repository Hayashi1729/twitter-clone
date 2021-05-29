defmodule ProjectWeb.UserControllerTest do
  use ProjectWeb.ConnCase

  import Project.Factory

  describe "Logged-In User" do
    setup %{conn: conn} do
      {:ok, user} = Project.Accounts.register_user(params_for(:register_user))
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn, user: user}
    end

    test "accesses index page", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert html_response(conn, 200) =~ "user-index"
    end

    test "accesses New User page", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :new))
      assert html_response(conn, 200) =~ "user-new"
    end

    test "accesses Show User page", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :show, user.id))
      assert html_response(conn, 200) =~ "user-show"
    end

    test "accesses Edit User page", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :edit, user.id))
      assert html_response(conn, 200) =~ "user-edit"
    end
  end

  describe "Non Logged-In User" do
    setup %{conn: conn} do
      {:ok, user} = Project.Accounts.register_user(params_for(:register_user))

      {:ok, conn: conn, user: user}
    end

    test "accesses index page", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert redirected_to(conn, 302) == "/"
    end

    test "accesses New User page", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :new))
      assert html_response(conn, 200) =~ "user-new"
    end

    test "accesses Show User page", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :show, user.id))
      assert redirected_to(conn, 302) == "/"
    end

    test "accesses Edit User page", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :edit, user.id))
      assert redirected_to(conn, 302) == "/"
    end
  end
end
