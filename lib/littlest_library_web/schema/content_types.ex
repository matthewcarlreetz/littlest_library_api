defmodule LittlestLibraryWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  object :library do
    field :id, :id
    field :address, :string
    field :city, :string
    field :state, :string
    field :zip, :string
  end
end
