defmodule Project.Twitter do
  @moduledoc """
  The Twitter context.
  """

  import Ecto.Query, warn: false
  alias Project.Repo
  alias Project.Twitter.Post
  alias Project.Twitter.Favorite

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
  あるユーザーのお気に入り登録一覧のリストを返す。
  """
  @spec list_favorite_posts(integer) :: list(Favorite.t())
  def list_favorite_posts(user_id) do
    Favorite
    |> where([f], f.user_id == ^user_id)
    |> Repo.all()
  end

  @doc """
  あるツイートに記録されたお気に入り一覧のリストを返す。
  """
  @spec list_favorite_users(integer) :: list(Favorite.t())
  def list_favorite_users(post_id) do
    Favorite
    |> where([f], f.post_id == ^post_id)
    |> Repo.all()
  end

  @doc """
  Create a favorite.
  """
  @spec create_favorite(integer, integer) :: {:ok, Favorite.t()} | {:error, %Ecto.Changeset{}}
  def create_favorite(post_id, user_id) do
    attrs = %{post_id: post_id, user_id: user_id}
    
    %Favorite{}
    |> Favorite.changeset(attrs)
    |> Repo.insert()
  end
  
  @doc """
  Delete a favorite.
  """
  @spec delete_favorite(Favorite.t()) :: {:ok, Favorite.t()} | {:error, %Ecto.Changeset{}}
  def delete_favorite(%Favorite{} = fav) do
    Repo.delete(fav)
  end

  @doc """
  Returns true if a favorite exists; otherwise returns false.
  """
  @spec is_favorited?(integer, integer) :: boolean
  def is_favorited?(post_id, user_id) do
    Favorite
    |> where([f], f.post_id == ^post_id and f.user_id == ^user_id)
    |> Repo.exists?()
  end
end
