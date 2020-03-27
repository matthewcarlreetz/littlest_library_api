defmodule LittlestLibrary.LibrariesTest do
  use LittlestLibrary.DataCase

  describe "libraries" do
    alias LittlestLibrary.Libraries.{Library, LibraryStore}

    @valid_attrs %{
      address: "some address",
      city: "some city",
      image: "some image",
      latitude: 120.5,
      longitude: 120.5,
      state: "some state",
      status: "some status",
      thumbnail: "some thumbnail",
      zip: "some zip"
    }
    @update_attrs %{
      address: "some updated address",
      city: "some updated city",
      image: "some updated image",
      latitude: 456.7,
      longitude: 456.7,
      state: "some updated state",
      status: "some updated status",
      thumbnail: "some updated thumbnail",
      zip: "some updated zip"
    }
    @invalid_attrs %{
      address: nil,
      city: nil,
      image: nil,
      latitude: nil,
      longitude: nil,
      state: nil,
      status: nil,
      thumbnail: nil,
      zip: nil
    }

    def library_fixture(attrs \\ %{}) do
      {:ok, library} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LibraryStore.create_library()

      library
    end

    test "list_libraries/0 returns all libraries" do
      library = library_fixture()
      assert LibraryStore.list_libraries() == [library]
    end

    test "get_library!/1 returns the library with given id" do
      library = library_fixture()
      assert LibraryStore.get_library!(library.id) == library
    end

    test "create_library/1 with valid data creates a library" do
      assert {:ok, %Library{} = library} = LibraryStore.create_library(@valid_attrs)
      assert library.address == "some address"
      assert library.city == "some city"
      assert library.image == "some image"
      assert library.latitude == 120.5
      assert library.longitude == 120.5
      assert library.state == "some state"
      assert library.status == "some status"
      assert library.thumbnail == "some thumbnail"
      assert library.zip == "some zip"
    end

    test "create_library/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LibraryStore.create_library(@invalid_attrs)
    end

    test "update_library/2 with valid data updates the library" do
      library = library_fixture()
      assert {:ok, %Library{} = library} = LibraryStore.update_library(library, @update_attrs)
      assert library.address == "some updated address"
      assert library.city == "some updated city"
      assert library.image == "some updated image"
      assert library.latitude == 456.7
      assert library.longitude == 456.7
      assert library.state == "some updated state"
      assert library.status == "some updated status"
      assert library.thumbnail == "some updated thumbnail"
      assert library.zip == "some updated zip"
    end

    test "update_library/2 with invalid data returns error changeset" do
      library = library_fixture()
      assert {:error, %Ecto.Changeset{}} = LibraryStore.update_library(library, @invalid_attrs)
      assert library == LibraryStore.get_library!(library.id)
    end

    test "delete_library/1 deletes the library" do
      library = library_fixture()
      assert {:ok, %Library{}} = LibraryStore.delete_library(library)
      assert_raise Ecto.NoResultsError, fn -> LibraryStore.get_library!(library.id) end
    end

    test "change_library/1 returns a library changeset" do
      library = library_fixture()
      assert %Ecto.Changeset{} = LibraryStore.change_library(library)
    end
  end
end
