defmodule LittlestLibrary.Libraries.Library do
  use Ecto.Schema
  import Ecto.Changeset

  schema "libraries" do
    field :address, :string
    field :city, :string
    field :state, :string
    field :zip, :string
    field :latitude, :float
    field :longitude, :float
    field :status, :string
    field :image, :binary
    field :thumbnail, :binary

    timestamps()
  end

  @doc false
  def changeset(library, attrs) do
    library
    |> cast(attrs, [
      :address,
      :city,
      :state,
      :zip,
      :latitude,
      :longitude,
      :image,
      :thumbnail,
      :status
    ])
    |> validate_required([:address, :city, :state, :zip, :latitude, :longitude, :status])
  end
end
