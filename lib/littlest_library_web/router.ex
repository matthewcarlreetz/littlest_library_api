defmodule LittlestLibraryWeb.Router do
  use LittlestLibraryWeb, :router
  use Pow.Phoenix.Router

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

  pipeline :api do
    plug :accepts, ["json"]
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

  # Other scopes may use custom stacks.
  # scope "/api", LittlestLibraryWeb do
  #   pipe_through :api
  # end
end
