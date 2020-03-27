defmodule LittlestLibraryWeb.Router do
  use LittlestLibraryWeb, :router
  use Pow.Phoenix.Router

  pipeline :graphql do
    plug(LittlestLibraryWeb.Plugs.AbsintheContext)
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", LittlestLibraryWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", LittlestLibraryWeb do
    pipe_through [:browser, :protected]

    # Add your protected routes here
  end

  scope "/graph" do
    pipe_through(:graphql)
    forward("/", Absinthe.Plug, schema: LittlestLibraryWeb.Schema)
  end

  scope "/graphiql" do
    pipe_through(:graphql)

    forward("/", Absinthe.Plug.GraphiQL,
      schema: LittlestLibraryWeb.Schema,
      interface: :playground
    )
  end
end
