defmodule LittlestLibraryWeb.Resolvers.Libraries do
  alias LittlestLibrary.Libraries.LibraryStore

  @moduledoc """
  Graph resolver for lane objects
  """

  def list_libraries(
        _parent,
        %{},
        %{context: %{current_user: _current_user}}
      ) do
    {:ok, LibraryStore.list_libraries()}
  end

  def list_libraries(
        _parent,
        %{},
        _
      ) do
    {:error, :unauthorized}
  end
end
