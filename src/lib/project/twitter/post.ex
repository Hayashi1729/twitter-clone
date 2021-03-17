defmodule Project.Twitter.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  A post
  """
  @type t :: %__MODULE__{
    id: integer,
    tweet: String.t(),

    user_id: integer,
    user: User.t(),

    inserted_at: NaiveDateTime.t(),
    updated_at: NaiveDateTime.t()
  }
  schema "posts" do
    field :tweet, :string

    belongs_to :user, Project.Accounts.User
    has_many :favorites, Project.Twitter.Favorite

    timestamps()
  end

  @doc false
  @spec changeset(struct(), map()) :: Ecto.Changeset.t()
  def changeset(post, attrs \\ %{}) do
    post
    |> cast(attrs, [:tweet])
    |> validate_required([:tweet])
    |> validate_length(:tweet, min: 1, max: 140)
  end
end
