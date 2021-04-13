defmodule ProjectWeb.PostControllerTest do
  use ProjectWeb.ConnCase, async: true

  import Project.Factory

  describe "Logged-In User" do
    setup %{conn: conn} do
      {:ok, user} = Project.Accounts.register_user(params_for(:register_user))
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn, user: user}
    end

    test "lists all posts", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert html_response(conn, 200) =~ "post-index"
    end

    # test "redirects to index when data is valid when create post", %{conn: conn} do
    #  conn = post(conn, Routes.post_path(conn, :create), post: params_for(:post))
    #  assert redirected_to(conn, 302) == "/posts"
    # end
    #
    # test "renders errors when data is invalid when create post", %{conn: conn} do
    #  conn = post(conn, Routes.post_path(conn, :create), post: params_for(:invalid_post))
    #  assert html_response(conn, 200) =~ "New Post"
    # end
    #
    # setup [:create_post]
    #
    # test "deletes chosen post", %{conn: conn, post: post} do
    #  conn = delete(conn, Routes.post_path(conn, :delete, post))
    #  assert redirected_to(conn) == Routes.post_path(conn, :index)
    #  assert redirected_to(conn, 302) == "/posts"
    # end
  end

  describe "Non Logged-In User" do
    test "accesses index page", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert redirected_to(conn, 302) == "/"
    end

    test "accesses New Post page", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert redirected_to(conn, 302) == "/"
    end
  end

  # defp create_post(_) do
  #  post = insert(:post)
  #  %{post: post}
  # end
end
