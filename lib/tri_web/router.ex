defmodule TriWeb.Router do
  use TriWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TriWeb do
    pipe_through :api

    post "/user", UserController, :create

    post "/login", SessionController, :login
  end

  scope "/", TriWeb do
    pipe_through :api

    get "/user/:id", UserController, :show
  end
end
