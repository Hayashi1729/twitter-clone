defmodule Project.Twitter do
  @moduledoc """
  The Twitter context.
  """

  import Ecto.Query, warn: false
  alias Project.Repo

  alias Project.Twitter.Post
  alias Project.Twitter.User

  @spec list_posts :: [%Post{}]
  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Post
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @spec get_post!(integer) :: %Post{}
  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id) do
    Post
    |> Repo.get!(id)
    |> Repo.preload(:user)
  end

  @spec create_post(Ecto.Changeset.t(), map) :: {:ok, %Post{}} | {:error, %Ecto.Changeset{}}
  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(changeset, attrs) do
    changeset
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_post(%Post{}, map) :: {:ok, %Post{}} | {:error, %Ecto.Changeset{}}
  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @spec delete_post(%Post{}) :: {:ok, %Post{}} | {:error, %Ecto.Changeset{}}
  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @spec change_post(%Post{}, map) :: %Ecto.Changeset{data: %Post{}}
  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  @spec list_users :: [%User{}]
  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @spec get_user(integer) :: %User{} | nil
  @doc """
  Gets a single user.

  Retrun nil if no user was found.

  ## Examples

      iex> get_user(123)
      %User{}

      iex> get_user(456)
      nil

  """
  def get_user(id), do: Repo.get(User, id)

  @spec get_user_by(Keyword.t()) :: %User{} | nil
  @doc """
  Get a sigle user from the query

  ## Examples

      iex> get_user_by(field: value)
      %User{}

      iex> get_user_by(field: bad_value)
      nil

  """
  def get_user_by(params), do: Repo.get_by(User, params)

  @spec create_user(map) :: {:ok, %User{}} | {:error, %Ecto.Changeset{}}
  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_user(%User{}, map) :: {:ok, %User{}} | {:error, %Ecto.Changeset{}}
  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.registration_changeset(attrs)
    |> Repo.update()
  end

  @spec delete_user(%User{}) :: {:ok, %User{}} | {:error, %Ecto.Changeset{}}
  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @spec change_registration(%User{}, %{}) :: %Ecto.Changeset{data: %User{}}
  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

   ## Examples

      iex> change_registration(user)
      %Ecto.Changeset{data: %User{}}
  """
  def change_registration(%User{} = user, params) do
    User.registration_changeset(user, params)
  end

  @spec register_user(map()) ::  {:ok, %User{}} | {:error, Ecto.Changeset.t()}
  @doc """
  Register a user.

  ## Examples

      iex> register_user(%{field: value})
      {:ok, %User{}}

      iex> register_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def register_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @spec authenticate_by_username_and_pass(String.t(), Ecto.Schema.t() | nil) :: {:ok, %User{}} | {:error, :unauthorized} | {:error, :not_found}
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
