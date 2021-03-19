defmodule Project.Repo.Migrations.AddOnDeleteToPost do
  use Ecto.Migration

  def up do
    drop constraint(:posts, "posts_user_id_fkey")
    alter table(:posts) do
      modify :user_id, references(:users, on_delete: :delete_all)
    end
  end

  def down do
    drop constraint(:posts, "posts_user_id_fkey")
    alter table(:posts) do
      modify :user_id, references(:users, on_delete: :nothing)
    end
  end
end
