defmodule LittlestLibraryWeb.Schema.Users do
  use Absinthe.Schema.Notation

  alias LittlestLibraryWeb.Resolvers.Users

  object :user do
    field :email, :string
    field :token, :string
    field :renew_token, :string
  end

  object :user_queries do
    field :current_user, :user do
      resolve(&Users.current_user/3)
    end
  end

  object :user_mutations do
    @desc "Sign in"
    field :authenticate, type: :user do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Users.authenticate/3)
    end
  end
end
