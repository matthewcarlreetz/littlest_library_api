defmodule LittlestLibraryWeb.Schema.Libraries do
  use Absinthe.Schema.Notation
  alias LittlestLibraryWeb.Resolvers.Libraries

  object :library do
    field :address, :string
    field :city, :string
    field :state, :string
    field :zip, :string
    field :latitude, :float
    field :longitude, :float
    field :image, :string
    field :thumbnail, :string
    field :status, :string
  end

  object :library_queries do
    @desc "Get all libraries"
    field :libraries, list_of(:library) do
      resolve(&Libraries.list_libraries/3)
    end
  end
end
