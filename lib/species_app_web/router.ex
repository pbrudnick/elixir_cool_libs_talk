defmodule SpeciesAppWeb.Router do
  use SpeciesAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug(SpeciesApp.Auth.Plug.CurrentUser)
  end

  pipeline :auth do
    plug(SpeciesApp.Auth.AuthAccessPipeline)
  end

  scope "/" do

    scope "/admin", SpeciesAppWeb do
      pipe_through :browser

      resources "/users", UserController, only: [:show, :new, :create]
      resources "/sessions", SessionController, only: [:new, :create,
                                                   :delete]
      scope "/" do
        pipe_through :auth

        get "/", SpecieController, :index
        resources "/species", SpecieController
      end
    end

    scope "/api", SpeciesAppWeb do
      pipe_through :api

      get "/species", SpecieController, :index_json
      get "/species/:id", SpecieController, :show_json
      get "/species/:id/observations", SpecieController, :observations_json
    end
  end
end
