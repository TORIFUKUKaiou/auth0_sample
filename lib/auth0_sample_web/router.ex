defmodule Auth0SampleWeb.Router do
  use Auth0SampleWeb, :router

  import Auth0SampleWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Auth0SampleWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", Auth0SampleWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  scope "/", Auth0SampleWeb do
    pipe_through :browser

    live "/", HomeLive, :index, session: {Auth0SampleWeb.Helpers, :keep_current_user, []}
  end

  scope "/", Auth0SampleWeb do
    pipe_through [:browser, :require_authenticated_user]

    live "/page", PageLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Auth0SampleWeb do
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
      live_dashboard "/dashboard", metrics: Auth0SampleWeb.Telemetry
    end
  end
end
