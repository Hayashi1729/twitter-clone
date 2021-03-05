defmodule Project.Twitter.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string

    has_many :posts, Project.Twitter.Post

    timestamps()
  end

  @spec registration_changeset(struct(), %{}) :: Ecto.Changeset.t()
  @doc false
  def registration_changeset(user, params) do
    user
    |> changeset(params)
    |> cast(params, [:password],[])
    |> validate_required([:password], message: "パスワードを入力してください。パスワードは6文字以上100文字以下である必要があります。")
    |> validate_length(:password, min: 6, max: 100, message: "パスワードは6文字以上100文字以下である必要があります。")
    |> put_pass_hash()
  end

  @spec put_pass_hash(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end

  @spec changeset(struct(), map()) :: Ecto.Changeset.t()
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username], message: "ユーザーネームを入力してください")
    |> validate_length(:username, min: 1, max: 20, message: "ユーザーネームは20文字以下である必要があります。")
    |> unique_constraint([:username], message: "このユーザーネームは既に取得されています。")
  end
end
