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
      add :image, :string, size: 2_560
      add :thumbnail, :string, size: 2_560
      add :status, :string

      timestamps()
    end
  end
end
