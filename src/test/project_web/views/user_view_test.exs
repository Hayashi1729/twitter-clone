defmodule ProjectWeb.UserViewTest do
  use ProjectWeb.ConnCase, async: true
  import Phoenix.View

  test "renders index.html", %{conn: conn} do
    users = [
      %Project.Accounts.User{id: 1, username: "User1"},
      %Project.Accounts.User{id: 2, username: "User2"}
    ]

    content =
      render_to_string(
        ProjectWeb.UserView,
        "index.html",
        conn: conn,
        users: users
      )

    assert String.contains?(content, "user-index")
  end

  test "renders new.html", %{conn: conn} do
    changeset = Project.Accounts.User.registration_changeset(%Project.Accounts.User{}, %{})

    content =
      render_to_string(ProjectWeb.UserView, "new.html",
        conn: conn,
        changeset: changeset
      )

    assert String.contains?(content, "user-new")
  end

  test "renders show.html", %{conn: conn} do
    user = %Project.Accounts.User{id: 1, username: "User1"}

    content =
      render_to_string(ProjectWeb.UserView, "show.html",
        conn: conn,
        user: user
      )

    assert String.contains?(content, "user-show")
  end
end
