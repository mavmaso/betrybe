defmodule TriWeb.Router do
  use TriWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt do
    plug TriWeb.AuthPlug
    plug :accepts, ["json"]
  end

  scope "/", TriWeb do
    pipe_through :api

    post "/user", UserController, :create

    post "/login", SessionController, :login
  end

  scope "/", TriWeb do
    pipe_through :jwt

    get "/user", UserController, :index
    get "/user/:id", UserController, :show
    delete "/user/me", UserController, :delete

    resources "/post", PostController, except: [:new, :edit, :show]
    get "/post/search", PostController, :search
  end
end
