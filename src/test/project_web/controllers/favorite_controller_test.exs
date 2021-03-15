defmodule ProjectWeb.FavoriteControllerTest do
  use ProjectWeb.ConnCase

  import Project.Factory

  setup %{conn: conn} do
    post = insert(:post)
    {:ok, user} = Project.Accounts.register_user(params_for(:register_user))
    conn = assign(conn, :current_user, user)

    {:ok, conn: conn, post: post}
  end

  test "create", %{conn: conn, post: post} do
    conn = post(conn, Routes.post_favorite_path(conn, :create, post))
    assert redirected_to(conn, 302) == "/posts"
  end

  test "delete", %{conn: conn, post: post} do
    conn = post(conn, Routes.post_favorite_path(conn, :delete, post))
    assert redirected_to(conn, 302) == "/posts"
  end
end