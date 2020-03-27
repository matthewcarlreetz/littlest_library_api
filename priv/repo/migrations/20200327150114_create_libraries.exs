defmodule LittlestLibrary.Repo.Migrations.CreateLibraries do
  use Ecto.Migration

  def change do
    create table(:libraries) do
      add :address, :string
      add :city, :string
      add :state, :string
      add :zip, :string
      add :latitude, :float
      add :longitude, :float
      add :image, :binary
      add :thumbnail, :binary
      add :status, :string

      timestamps()
    end
  end
end
