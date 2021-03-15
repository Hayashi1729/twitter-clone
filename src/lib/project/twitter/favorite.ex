defmodule Project.Twitter.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  A favorite.
  A join table between User table and Post table.
  """
  @type t :: %__MODULE__{
    user_id: integer,
    user: User.t(),

    post_id: integer,
    post: Post.t(),

    inserted_at: NaiveDateTime.t(),
    updated_at: NaiveDateTime.t()
  }
  schema "favorites" do
    belongs_to :user, Project.Accounts.User
    belongs_to :post, Project.Twitter.Post

    timestamps()
  end
end