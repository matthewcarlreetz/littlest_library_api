defmodule LittlestLibraryWeb.Resolvers.Libraries do
  alias LittlestLibrary.Libraries.LibraryStore
  alias LittlestLibrary.Utils.Haversine
  alias LittlestLibrary.Uploaders.Avatar

  @moduledoc """
  Graph resolver for lane objects
  """

  def pending_libraries(_parent, %{}, %{context: %{current_user: _current_user}}) do
    {:ok, LibraryStore.list_pending_libraries()}
  end

  def pending_libraries(_parent, %{}, _) do
    {:error, :unauthorized}
  end

  def list_libraries(_parent, %{}, %{context: %{current_user: _current_user}}) do
    {:ok, LibraryStore.list_libraries()}
  end

  def list_libraries(_parent, %{}, _) do
    {:error, :unauthorized}
  end

  def nearby_libraries(_parent, %{latitude: latitude, longitude: longitude}, info) do
    requested_fields = Absinthe.Resolution.project(info) |> Enum.map(& &1.name)

    # TODO: Filter this down with a sql query before running Haversine
    all_libraries = LibraryStore.list_approved_libraries()
    libraries = Haversine.within_distance(all_libraries, {latitude, longitude}, 40)

    mapped_libraries =
      libraries
      |> Enum.map(fn lib ->
        avatar = %{avatar_uuid: lib.avatar_uuid}

        lib =
          if Enum.member?(requested_fields, "image") do
            image = Avatar.url({"avatar.png", avatar}, :resized)
            Map.put(lib, :image, image)
          else
            lib
          end

        lib =
          if Enum.member?(requested_fields, "thumbnail") do
            thumbnail = Avatar.url({"avatar.png", avatar}, :thumb)
            Map.put(lib, :thumbnail, thumbnail)
          else
            lib
          end

        lib
      end)

    {:ok, mapped_libraries}
  end

  def get_library(_parent, %{id: id}, info) do
    requested_fields = Absinthe.Resolution.project(info) |> Enum.map(& &1.name)

    lib = LibraryStore.get_library!(id)
    avatar = %{avatar_uuid: lib.avatar_uuid}

    lib =
      if Enum.member?(requested_fields, "image") do
        image = Avatar.url({"avatar.png", avatar}, :resized)
        Map.put(lib, :image, image)
      else
        lib
      end

    lib =
      if Enum.member?(requested_fields, "thumbnail") do
        thumbnail = Avatar.url({"avatar.png", avatar}, :thumb)
        Map.put(lib, :thumbnail, thumbnail)
      else
        lib
      end

    {:ok, lib}
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
    # one_hundred_feet_in_km = 0.03048

    # all_libraries = LibraryStore.list_approved_libraries()

    # libraries =
    #   Haversine.within_distance(all_libraries, {latitude, longitude}, one_hundred_feet_in_km)

    # if Enum.empty?(libraries) do
    #   {:error, "There's already a library here"}
    # else
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

  # end

  def approve_library(_parent, %{id: id}, %{context: %{current_user: _current_user}}) do
    lib = LibraryStore.get_library!(id)
    LibraryStore.update_library(lib, %{status: "approved"})
  end

  def approve_library(_parent, %{}, _) do
    {:error, :unauthorized}
  end

  def disapprove_library(_parent, %{id: id}, %{context: %{current_user: _current_user}}) do
    lib = LibraryStore.get_library!(id)
    LibraryStore.update_library(lib, %{status: "disapproved"})
  end

  def disapprove_library(_parent, %{}, _) do
    {:error, :unauthorized}
  end
end
