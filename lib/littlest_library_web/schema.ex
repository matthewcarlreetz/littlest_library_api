defmodule LittlestLibraryWeb.Schema do
  use Absinthe.Schema

  import_types(LittlestLibraryWeb.Schema.Libraries)
  import_types(LittlestLibraryWeb.Schema.Users)

  query do
    import_fields(:library_queries)
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:user_mutations)
  end
end
