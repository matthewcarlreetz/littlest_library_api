defmodule LittlestLibraryWeb.Plugs.AbsintheContext do
  alias LittlestLibraryWeb.APIAuthPlug
  alias Pow.Plug

  def init(default), do: default

  def call(conn, _default), do: Absinthe.Plug.put_options(conn, context: build_context(conn))

  def build_context(conn) do
    config = Plug.fetch_config(conn)

    {_, u} = conn |> APIAuthPlug.fetch(config)

    case u do
      %LittlestLibrary.Users.User{} = user ->
        %{conn: conn, current_user: user}

      nil ->
        %{conn: conn}
    end
  end
end
