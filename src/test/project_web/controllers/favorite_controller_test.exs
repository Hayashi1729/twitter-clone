defmodule ProjectWeb.FavoriteControllerTest do
  use ProjectWeb.ConnCase

  import Project.Factory

  setup %{conn: conn} do
    post = insert(:post)
    {:ok, user} = Project.Accounts.register_user(params_for(:register_user))
    conn = assign(conn, :current_user, user)

    {:ok, conn: conn, post: post, user: user}
  end

  test "create", %{conn: conn, post: post} do
    conn = post(conn, Routes.post_favorite_path(conn, :create, post))
    fav = json_response(conn, 201)
    assert Map.keys(fav) == ["post_id", "user_id"]
  end

  test "delete", %{conn: conn, post: post, user: user} do
    Project.Twitter.create_favorite(post.id, user.id)
    conn = delete(conn, Routes.post_favorite_path(conn, :delete, post))

    assert response(conn, 204) == ""
  end
end
