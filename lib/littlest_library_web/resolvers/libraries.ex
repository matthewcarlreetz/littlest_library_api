defmodule LittlestLibraryWeb.Resolvers.Libraries do
  alias LittlestLibrary.Libraries.LibraryStore
  alias LittlestLibrary.Utils.Haversine
  alias LittlestLibrary.Uploaders.Avatar

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

    libraries = Haversine.within_distance(all_libraries, {latitude, longitude}, 40)

    mapped_libraries =
      libraries
      |> Enum.map(fn lib ->
        avatar = %{avatar_uuid: lib.avatar_uuid}
        thumbnail = Avatar.url({"avatar.png", avatar}, :thumb)
        Map.put(lib, :thumbnail, thumbnail)
      end)

    {:ok, mapped_libraries}
  end

  def create_library(
        _parent,
        %{
          file: file,
          latitude: latitude,
          longitude: longitude,
          address: address,
          city: city,
          state: state,
          zip: zip
        },
        _
      ) do
    avatar_uuid = Ecto.UUID.generate()
    Avatar.store({file, %{avatar_uuid: avatar_uuid}})

    LibraryStore.create_library(%{
      address: address,
      city: city,
      state: state,
      zip: zip,
      latitude: latitude,
      longitude: longitude,
      avatar_uuid: avatar_uuid
    })
  end
end
