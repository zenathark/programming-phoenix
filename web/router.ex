defmodule Rumbl.Router do
  use Rumbl.Web, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(Rumbl.Auth, repo: Rumbl.Repo)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", Rumbl do
    # Use the default browser stack
    pipe_through(:browser)

    resources("/users", UserController, [:index, :new, :show, :create])
    get("/", PageController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", Rumbl do
  #   pipe_through :api
  # end
end
