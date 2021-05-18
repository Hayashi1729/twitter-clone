defmodule ProjectWeb.Router do
  use ProjectWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ProjectWeb.AuthorizationPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug ProjectWeb.AuthorizationPlug
  end

  pipeline :auth do
    plug ProjectWeb.AuthUserPlug
  end

  pipeline :redirect_if_authenticated do
    plug ProjectWeb.RedirectPlug
  end

  scope "/", ProjectWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController, only: [:new, :create]
  end

  scope "/", ProjectWeb do
    pipe_through [:browser, :auth]

    resources "/posts", PostController
    resources "/users", UserController, except: [:new, :create]
    resources "/sessions", SessionController, only: [:delete]
  end

  scope "/", ProjectWeb do
    pipe_through [:browser, :redirect_if_authenticated]

    resources "/sessions", SessionController, only: [:new, :create]
  end

  scope "/", ProjectWeb do
    pipe_through [:api, :auth]

    post "/favorite", FavoriteController, :create
    delete "/favorite", FavoriteController, :delete
  end

  scope "/api", ProjectWeb do
    pipe_through :api
    post "/users", UserApiController, :create
  end

  scope "/api", ProjectWeb do
    pipe_through [:api, :auth]
    resources "/users", UserApiController, except: [:new, :create]
    resources "/posts", PostApiController
    get "/favorited_post", PostApiController, :favorited_post
    get "/favorites", FavoriteApiController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ProjectWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ProjectWeb.Telemetry
    end
  end
end
