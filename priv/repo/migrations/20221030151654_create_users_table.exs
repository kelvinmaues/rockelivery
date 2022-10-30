defmodule Rockelivery.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table :users do
      add :address, :string
      add :age, :integer
      add :zip_code, :string
      add :document_number, :string
      add :email, :string
      add :password_hash, :string
      add :name, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:document_number])
  end
end
