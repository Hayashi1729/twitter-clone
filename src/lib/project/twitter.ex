defmodule Project.Twitter do
  @moduledoc """
  The Twitter context.
  """

  import Ecto.Query, warn: false
  alias Project.Repo

  alias Project.Twitter.Post
  alias Project.Twitter.User

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  @spec list_posts :: list(Post.t())
  def list_posts do
    Post
    |> preload(:user)
    |> Repo.all()
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_post!(integer) :: Post.t()
  def get_post!(id) do
    Post
    |> preload(:user)
    |> Repo.get!(id)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_post(Ecto.Changeset.t(), map) :: {:ok, Post.t()} | {:error, %Ecto.Changeset{}}
  def create_post(changeset, attrs) do
    changeset
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_post(Post.t(), map) :: {:ok, Post.t()} | {:error, %Ecto.Changeset{}}
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_post(Post.t()) :: {:ok, Post.t()} | {:error, %Ecto.Changeset{}}
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  @spec list_users :: list(User.t())
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Retrun nil if no user was found.

  ## Examples

      iex> get_user(123)
      %User{}

      iex> get_user(456)
      nil

  """
  @spec get_user(integer) :: User.t() | nil
  def get_user(id), do: Repo.get(User, id)

  @doc """
  Get a sigle user from the query

  ## Examples

      iex> get_user_by(field: value)
      %User{}

      iex> get_user_by(field: bad_value)
      nil

  """
  @spec get_user_by(Keyword.t()) :: User.t() | nil
  def get_user_by(params), do: Repo.get_by(User, params)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_user(map) :: {:ok, User.t()} | {:error, %Ecto.Changeset{}}
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_user(User.t(), map) :: {:ok, User.t()} | {:error, %Ecto.Changeset{}}
  def update_user(%User{} = user, attrs) do
    user
    |> User.registration_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_user(User.t()) :: {:ok, User.t()} | {:error, %Ecto.Changeset{}}
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Register a user.

  ## Examples

      iex> register_user(%{field: value})
      {:ok, %User{}}

      iex> register_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  @spec register_user(map()) ::  {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def register_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  ユーザーネームとパスワードによって認証を行います。

  ## Examples

      iex> authenticate_by_username_and_pass("existing_user", "correct_password")
      {:ok, %User{username: "existing_user"}}

      iex> authenticate_by_username_and_pass("existing_user", "incorrect_password")
      {:error, :unauthorized}

      iex> authenticate_by_username_and_pass("non_existing_user", "password")
      {:error, :not_found}
  """
  @spec authenticate_by_username_and_pass(String.t(), Ecto.Schema.t() | nil) :: {:ok, User.t()} | {:error, :unauthorized} | {:error, :not_found}
  def authenticate_by_username_and_pass(username, given_pass) do
    user = get_user_by(username: username)

    cond do
      user && Pbkdf2.verify_pass(given_pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end
end
