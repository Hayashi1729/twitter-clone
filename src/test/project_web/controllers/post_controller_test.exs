defmodule ProjectWeb.PostControllerTest do
  use ProjectWeb.ConnCase, async: true

  @create_attrs %{tweet: "some tweet"}
  @invalid_attrs %{tweet: nil}

  setup %{conn: conn, login_as: username} do
      user = user_fixture(username: username)
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn, user: user}
  end

  describe "index" do
    @tag login_as: "max"
    test "lists all posts", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert html_response(conn, 200) =~ "ツイート一覧"
    end
  end

  describe "create post" do
    @tag login_as: "max"
    test "redirects to index when data is valid", %{conn: conn} do
      conn = post(conn, Routes.post_path(conn, :create), post: @create_attrs)
      assert html_response(conn, 302) =~ "redirected"
    end

    @tag login_as: "max"
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.post_path(conn, :create), post: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, Routes.post_path(conn, :delete, post))
      assert redirected_to(conn) == Routes.post_path(conn, :index)
      assert html_response(conn, 302) =~ "redirected"
    end
  end

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end


end