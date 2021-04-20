defmodule ProjectWeb.UserApiControllerTest do
  use ProjectWeb.ConnCase, async: true

  import Project.Factory

  describe "Logged-In User" do
    setup %{conn: conn} do
      {:ok, user} = Project.Accounts.register_user(params_for(:register_user))
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn, user: user}
    end

    test "rendering index", %{conn: conn} do
      {:ok, _another_user} = Project.Accounts.register_user(params_for(:register_user))
      conn = get(conn, Routes.user_api_path(conn, :index))
      user_list = json_response(conn, 200)

      Enum.each(user_list, fn x ->
        assert Map.keys(x) == [
                 "id",
                 "username"
               ]
      end)
    end

    test "rendering show", %{conn: conn} do
      conn = get(conn, Routes.user_api_path(conn, :show, conn.assigns.current_user.id))
      user = json_response(conn, 200)

      assert Map.keys(user) == [
               "id",
               "username"
             ]
    end

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_api_path(conn, :delete, user))
      assert response(conn, 204) == ""
    end
  end

  test "create user", %{conn: conn} do
    conn = post(conn, Routes.user_api_path(conn, :create), user: params_for(:register_user))
    user = json_response(conn, 201)

    assert Map.keys(user) == [
             "id",
             "username"
           ]
  end
end
