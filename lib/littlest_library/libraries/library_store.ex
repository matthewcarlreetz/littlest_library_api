defmodule LittlestLibrary.Libraries.LibraryStore do
  @moduledoc """
  The LibrarieStore context.
  """

  import Ecto.Query, warn: false
  alias LittlestLibrary.Repo

  alias LittlestLibrary.Libraries.Library

  @doc """
  Returns the list of libraries.

  ## Examples

      iex> list_libraries()
      [%Library{}, ...]

  """
  def list_libraries do
    Repo.all(Library)
  end

  @doc """
  Returns the list of approved libraries.

  ## Examples

      iex> list_approve_libraries()
      [%Library{}, ...]

  """
  def list_approved_libraries do
    query =
      from l in Library,
        where: l.status == "approved"

    Repo.all(query)
  end

  @doc """
  Gets a single library.

  Raises `Ecto.NoResultsError` if the Library does not exist.

  ## Examples

      iex> get_library!(123)
      %Library{}

      iex> get_library!(456)
      ** (Ecto.NoResultsError)

  """
  def get_library!(id), do: Repo.get!(Library, id)

  @doc """
  Creates a library.

  ## Examples

      iex> create_library(%{field: value})
      {:ok, %Library{}}

      iex> create_library(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_library(attrs \\ %{}) do
    %Library{}
    |> Library.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a library.

  ## Examples

      iex> update_library(library, %{field: new_value})
      {:ok, %Library{}}

      iex> update_library(library, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_library(%Library{} = library, attrs) do
    library
    |> Library.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a library.

  ## Examples

      iex> delete_library(library)
      {:ok, %Library{}}

      iex> delete_library(library)
      {:error, %Ecto.Changeset{}}

  """
  def delete_library(%Library{} = library) do
    Repo.delete(library)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking library changes.

  ## Examples

      iex> change_library(library)
      %Ecto.Changeset{source: %Library{}}

  """
  def change_library(%Library{} = library) do
    Library.changeset(library, %{})
  end
end
