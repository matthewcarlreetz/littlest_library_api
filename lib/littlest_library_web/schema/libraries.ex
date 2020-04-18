defmodule LittlestLibraryWeb.Schema.Libraries do
  use Absinthe.Schema.Notation
  alias LittlestLibraryWeb.Resolvers.Libraries
  import_types(Absinthe.Plug.Types)

  object :library do
    field :id, :integer
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

  input_object :library_upload do
    field(:file, :upload)
    field(:latitude, non_null(:float))
    field(:longitude, non_null(:float))
  end

  object :library_mutations do
    @desc "Create a library"
    field :create_library, :library do
      arg(:library_upload, non_null(:library_upload))

      resolve(&Libraries.create_library/3)
    end
  end

  object :library_queries do
    @desc "Get all libraries"
    field :libraries, list_of(:library) do
      resolve(&Libraries.list_libraries/3)
    end

    field :nearby_libraries, list_of(:library) do
      arg(:latitude, non_null(:float))
      arg(:longitude, non_null(:float))
      resolve(&Libraries.nearby_libraries/3)
    end
  end
end
