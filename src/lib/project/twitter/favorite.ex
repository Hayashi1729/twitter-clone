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
  @derive {Jason.Encoder, only: [:user_id, :post_id]}
  schema "favorites" do
    belongs_to :user, Project.Accounts.User
    belongs_to :post, Project.Twitter.Post

    timestamps()
  end

  @doc false
  @spec changeset(struct(), map()) :: Ecto.Changeset.t()
  def changeset(favorite, attrs \\ %{}) do
    favorite
    |> cast(attrs, [:user_id, :post_id])
    |> validate_required([:user_id, :post_id])
    |> unique_constraint([:user_id, :post_id], message: "このツイートはすでにお気に入り登録されています。")
  end
end
