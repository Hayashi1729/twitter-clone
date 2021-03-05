defmodule ProjectWeb.SessonViewTest do
  use ProjectWeb.ConnCase, async: true
  import Phoenix.View

  test "renders new.html", %{conn: conn} do 
    changeset = Project.Twitter.change_registration(%Project.Twitter.User{}, %{})

    content =
      render_to_string(ProjectWeb.SessionView, "new.html",
        conn: conn,
        changeset: changeset
      )

    assert String.contains?(content, "Login")
  end
end