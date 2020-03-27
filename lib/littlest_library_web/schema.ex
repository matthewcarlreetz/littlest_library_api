defmodule LittlestLibraryWeb.Schema do
  use Absinthe.Schema

  import_types(LittlestLibraryWeb.Schema.Libraries)

  query do
    import_fields(:library_queries)
  end
end
