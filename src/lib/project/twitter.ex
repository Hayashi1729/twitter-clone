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

  def list_favorite_posts(user_id) do
    query = from f in Favorite,
      where: f.user_id == ^user_id
    Repo.all(query)
  end

  def list_favorite_users(post_id) do
    query = from f in Favorite,
      where: f.post_id == ^post_id
    Repo.all(query)
  end

  def create_favorite(post_id, user_id) do
    #changeset = Favorite.changeset(
    #  %Favorite{}, %{post_id: post_id, user_id: user_id}
    #)
    fav = %Favorite{post_id: post_id, user_id: user_id}
    Repo.insert(fav)
  end
  
  def delete_favorite(%Favorite{} = fav) do
    Repo.delete(fav)
  end

  def is_favorited?(post_id, user_id) do
    query = from f in Favorite,
      where: f.post_id == ^post_id and f.user_id == ^user_id
    Repo.exists?(query)
  end
end
