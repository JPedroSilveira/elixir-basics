defmodule LotteryWeb.Router do
  use LotteryWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LotteryWeb do
    pipe_through :api
    get "/health", HealthCheck.HealthCheckontroller, :index
    resources "/v1/user", Users.UserV1Controller, only: [:create, :show, :update]
    resources "/v1/event", Events.EventV1Controller, only: [:create, :show]
    resources "/v1/participation", Participations.ParticipationsV1Controller, only: [:create, :index]
    resources "/v1/winner", Winners.WinnerV1Controller, only: [:show]
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:lottery, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: LotteryWeb.Telemetry
    end
  end
end
