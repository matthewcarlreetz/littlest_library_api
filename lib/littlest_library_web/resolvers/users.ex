defmodule LittlestLibraryWeb.Resolvers.Users do
  @moduledoc """
  Graph resolver for lane objects
  """
  alias LittlestLibraryWeb.APIAuthPlug
  alias Pow.Plug

  def authenticate(
        _parent,
        %{email: email, password: password},
        %{context: %{conn: conn}}
      ) do
    conn
    |> Plug.authenticate_user(%{"email" => email, "password" => password})
    |> case do
      {:ok, conn} ->
        config = Plug.fetch_config(conn)

        {c, u} =
          conn
          |> APIAuthPlug.create(conn.assigns.current_user, config)

        {:ok,
         %{
           email: u.email,
           token: c.private[:api_auth_token],
           renew_token: c.private[:api_auth_token]
         }}

      {:error, _} ->
        {:error}
    end
  end

  def current_user(_, _, %{context: %{conn: conn}}) do
    IO.inspect(conn)
    config = Plug.fetch_config(conn)

    IO.inspect(conn |> APIAuthPlug.fetch(config))
    current_user = IO.inspect(conn |> Plug.current_user())
    IO.inspect("FUCKS")
    {:ok, user: current_user}
  end
end