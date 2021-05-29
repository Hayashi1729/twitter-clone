defmodule ProjectWeb.PostApiControllerTest do
  use ProjectWeb.ConnCase, async: true

  import Project.Factory

  describe "Logged-In User" do
    setup %{conn: conn} do
      post = insert(:post)
      {:ok, user} = Project.Accounts.register_user(params_for(:register_user))
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn, post: post}
    end

    test "rendering index", %{conn: conn} do
      _another_post = insert(:post)
      conn = get(conn, Routes.post_api_path(conn, :index))
      post_list = json_response(conn, 200)

      Enum.each(post_list, fn x ->
        assert Map.keys(x) == [
                 "favorites",
                 "id",
                 "inserted_at",
                 "tweet",
                 "user",
                 "user_id"
               ]
      end)
    end

    test "rendering favorite post", %{conn: conn, post: post} do
      current_user = conn.assigns.current_user
      Project.Twitter.create_favorite(post.id, current_user.id)
      conn = get(conn, Routes.post_api_path(conn, :favorited_post))
      fav = json_response(conn, 200)
      refute Enum.empty?(fav)
    end

    test "create post", %{conn: conn} do
      conn = post(conn, Routes.post_api_path(conn, :create), post: params_for(:post))
      post = json_response(conn, 201)

      assert Map.keys(post) == [
               "favorites",
               "id",
               "inserted_at",
               "tweet",
               "user",
               "user_id"
             ]
    end

    test "rendering show", %{conn: conn, post: post} do
      conn = get(conn, Routes.post_api_path(conn, :show, post.id))
      post = json_response(conn, 200)

      assert Map.keys(post) == [
               "favorites",
               "id",
               "inserted_at",
               "tweet",
               "user",
               "user_id"
             ]
    end

    test "update post", %{conn: conn, post: post} do
      params = %{tweet: "update post"}
      conn = put(conn, Routes.post_api_path(conn, :update, post.id), post: params)
      post = json_response(conn, 201)

      assert post["tweet"] == "update post"
    end

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, Routes.post_api_path(conn, :delete, post))
      assert response(conn, 204) == ""
    end
  end
end
