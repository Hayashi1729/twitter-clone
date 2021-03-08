ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Project.Repo, :manual)

defmodule Project.TestHelpers do
  alias Project.Twitter

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        username: "user#{System.unique_integer([:positive])}",
        password: attrs[:password] || "supersecret"
      })
      |> Twitter.register_user()

    user
  end

  def post_fixture(attrs \\ %{}) do
    changeset = Twitter.Post.changeset(%Twitter.Post{tweet: "some_text", user_id: 10, user: %Twitter.User{username: "Alice", id: 10}})
    {:ok, post} = Twitter.create_post(changeset, attrs)

    post
  end
end