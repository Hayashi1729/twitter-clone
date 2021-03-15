defmodule Project.Repo.Migrations.AddFavoritesTable do
  use Ecto.Migration

  def up do
    create table(:favorites) do
      add :user_id, references(:users)
      add :post_id, references(:posts)

      timestamps()
    end

    create unique_index(:favorites, [:user_id, :post_id])
  end
end
