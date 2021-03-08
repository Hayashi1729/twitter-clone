defmodule ProjectWeb.PostControllerTest do
  use ProjectWeb.ConnCase, async: true

  @create_attrs %{tweet: "some tweet"}
  @invalid_attrs %{tweet: nil}

  describe "Logged-In User" do
    setup %{conn: conn, login_as: username} do
        user = user_fixture(username: username)
        conn = assign(conn, :current_user, user)

        {:ok, conn: conn, user: user}
    end

    @tag login_as: "max"
    test "lists all posts", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert html_response(conn, 200) =~ "ツイート一覧"
    end

    @tag login_as: "max"
    test "redirects to index when data is valid when create post", %{conn: conn} do
      conn = post(conn, Routes.post_path(conn, :create), post: @create_attrs)
      assert html_response(conn, 302) =~ "redirected"
    end

    @tag login_as: "max"
    test "renders errors when data is invalid when create post", %{conn: conn} do
      conn = post(conn, Routes.post_path(conn, :create), post: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Post"
    end

    setup [:create_post]
    @tag login_as: "max"
    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, Routes.post_path(conn, :delete, post))
      assert redirected_to(conn) == Routes.post_path(conn, :index)
      assert html_response(conn, 302) =~ "redirected"
    end
  end

  describe "Non Logged-In User" do
    test "accesses index page", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert redirected_to(conn, 302) =~ "/"
    end

    test "accesses New Post page", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert redirected_to(conn, 302) =~ "/"
    end
  end

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end
end