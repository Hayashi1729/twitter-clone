defmodule ProjectWeb.FavoriteApiControllerTest do
  use ProjectWeb.ConnCase, async: true

  import Project.Factory

  describe "Logged-In User" do
    setup %{conn: conn} do
      {:ok, user} = Project.Accounts.register_user(params_for(:register_user))
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn}
    end

    test "rendering index", %{conn: conn} do
      current_user = conn.assigns.current_user
      post1 = insert(:post)
      Project.Twitter.create_favorite(post1.id, current_user.id)
      post2 = insert(:post)
      Project.Twitter.create_favorite(post2.id, current_user.id)

      conn = get(conn, Routes.favorite_api_path(conn, :index))
      fav_list = json_response(conn, 200)

      Enum.each(fav_list, fn x ->
        assert Map.keys(x) == [
                 "post_id",
                 "user_id"
               ]
      end)
    end
  end
end
