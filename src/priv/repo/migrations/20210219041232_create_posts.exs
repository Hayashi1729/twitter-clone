defmodule Project.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :tweet, :string
      add :username, :string

      timestamps()
    end

  end
end
