defmodule LittlestLibraryWeb.Resolvers.Libraries do
  alias LittlestLibrary.Libraries.LibraryStore
  alias LittlestLibrary.Utils.Haversine

  @moduledoc """
  Graph resolver for lane objects
  """

  def list_libraries(_parent, %{}, %{context: %{current_user: _current_user}}) do
    {:ok, LibraryStore.list_libraries()}
  end

  def list_libraries(_parent, %{}, _) do
    {:error, :unauthorized}
  end

  def nearby_libraries(_parent, %{latitude: latitude, longitude: longitude}, _) do
    # TODO: Filter this down with a sql query before running Haversine
    all_libraries = LibraryStore.list_libraries()

    {:ok, Haversine.within_distance(all_libraries, {latitude, longitude}, 40)}
  end

  def create_library(_parent, %{file: file, latitude: latitude, longitude: longitude}, _) do
    IO.inspect(file)
    IO.inspect(latitude)
    IO.inspect(longitude)
    # AvatarUploader.store(file)
  end
end
