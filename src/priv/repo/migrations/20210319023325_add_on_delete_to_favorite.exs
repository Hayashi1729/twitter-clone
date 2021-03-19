defmodule Project.Repo.Migrations.AddOnDeleteToFavorite do
  use Ecto.Migration

  def up do
    drop constraint(:favorites, "favorites_user_id_fkey")
    drop constraint(:favorites, "favorites_post_id_fkey")
    alter table(:favorites) do
      modify :user_id, references(:users, on_delete: :delete_all)
      modify :post_id, references(:posts, on_delete: :delete_all)
    end
  end

  def down do
    drop constraint(:favorites, "favorites_user_id_fkey")
    drop constraint(:favorites, "favorites_post_id_fkey")
    alter table(:favorites) do
      modify :user_id, references(:users, on_delete: :nothing)
      modify :post_id, references(:posts, on_delete: :nothing)
    end
  end
end
