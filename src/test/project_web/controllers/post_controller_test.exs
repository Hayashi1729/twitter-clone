defmodule ProjectWeb.PostControllerTest do
  use ProjectWeb.ConnCase, async: true

  import Project.Factory

  describe "Logged-In User" do
    setup %{conn: conn} do
      {:ok, user} = Project.Accounts.register_user(params_for(:register_user))
      conn = assign(conn, :current_user, user)
      post = insert(:post)

      {:ok, conn: conn, user: user, post: post}
    end

    test "accesses index page", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert html_response(conn, 200) =~ "post-index"
    end

    test "accesses New Post page", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :new))
      assert html_response(conn, 200) =~ "post-new"
    end

    test "accesses Show Post page", %{conn: conn, post: post} do
      conn = get(conn, Routes.post_path(conn, :show, post.id))
      assert html_response(conn, 200) =~ "post-show"
    end

    test "accesses Edit Post page", %{conn: conn, post: post} do
      conn = get(conn, Routes.post_path(conn, :edit, post.id))
      assert html_response(conn, 200) =~ "post-edit"
    end
  end

  describe "Non Logged-In User" do
    setup %{conn: conn} do
      post = insert(:post)

      {:ok, conn: conn, post: post}
    end

    test "accesses index page", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert redirected_to(conn, 302) == "/"
    end

    test "accesses New Post page", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :new))
      assert redirected_to(conn, 302) == "/"
    end

    test "accesses Show Post page", %{conn: conn, post: post} do
      conn = get(conn, Routes.post_path(conn, :show, post.id))
      assert redirected_to(conn, 302) == "/"
    end

    test "accesses Edit Post page", %{conn: conn, post: post} do
      conn = get(conn, Routes.post_path(conn, :edit, post.id))
      assert redirected_to(conn, 302) == "/"
    end
  end
end
