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
    field :distance, :float
    field :image, :string
    field :thumbnail, :string
    field :status, :string
  end

  object :library_mutations do
    @desc "Create a library"
    field :create_library, :library do
      arg(:file, non_null(:upload))
      arg(:latitude, non_null(:float))
      arg(:longitude, non_null(:float))
      arg(:address, non_null(:string))
      arg(:city, non_null(:string))
      arg(:state, non_null(:string))
      arg(:zip, non_null(:string))
      resolve(&Libraries.create_library/3)
    end

    field :approve_library, :library do
      @desc "Approve a library by id"
      arg(:id, non_null(:id))
      resolve(&Libraries.approve_library/3)
    end

    field :disapprove_library, :library do
      @desc "Disapprove a library by id"
      arg(:id, non_null(:id))
      resolve(&Libraries.disapprove_library/3)
    end
  end

  object :library_queries do
    @desc "Get all libraries"
    field :libraries, list_of(:library) do
      resolve(&Libraries.list_libraries/3)
    end

    @desc "Get all nearby libraries"
    field :nearby_libraries, list_of(:library) do
      arg(:latitude, non_null(:float))
      arg(:longitude, non_null(:float))
      resolve(&Libraries.nearby_libraries/3)
    end

    @desc "Get all pending libraries"
    field :pending_libraries, list_of(:library) do
      resolve(&Libraries.pending_libraries/3)
    end

    @desc "Get a library by id"
    field :library, :library do
      arg(:id, non_null(:id))
      resolve(&Libraries.get_library/3)
    end
  end
end
