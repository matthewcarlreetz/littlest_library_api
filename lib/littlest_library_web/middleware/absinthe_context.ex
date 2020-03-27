defmodule LittlestLibraryWeb.Plugs.AbsintheContext do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default), do: Absinthe.Plug.put_options(conn, context: %{conn: conn})
end
