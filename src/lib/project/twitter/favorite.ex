defmodule Project.Twitter.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  A favorite
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

  def changeset(favorite, attrs \\ %{}) do
    favorite
    |> cast(attrs, @required_fields)
    |> validate_required([:user_id, :post_id])
  end
end