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
  end

  scope "/" do

    scope "/admin", SpeciesAppWeb do
      pipe_through :browser

      get "/", SpecieController, :index
      resources "/species", SpecieController
    end

    scope "/api", SpeciesAppWeb do
      pipe_through :api

      get "/species", SpecieController, :get_json
    end
  end
end
