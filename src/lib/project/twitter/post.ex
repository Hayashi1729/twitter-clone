defmodule Project.Twitter.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :tweet, :string

    belongs_to :user, Project.Twitter.User

    timestamps()
  end

  @spec changeset(struct(), map()) :: Ecto.Changeset.t()
  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:tweet])
    |> validate_required([:tweet])
    |> validate_length(:tweet, min: 1, max: 140)
  end
end
