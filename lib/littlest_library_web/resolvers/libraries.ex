defmodule LittlestLibraryWeb.Resolvers.Libraries do
  alias LittlestLibrary.Libraries.LibraryStore

  @moduledoc """
  Graph resolver for lane objects
  """

  def list_libraries(
        _parent,
        %{},
        %{}
      ) do
    {:ok, LibraryStore.list_libraries()}
  end
end
