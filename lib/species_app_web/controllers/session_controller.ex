defmodule SpeciesAppWeb.SessionController do
  use SpeciesAppWeb, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    with {:ok, user} <- SpeciesApp.Auth.authenticate_user(email, password),
      {:ok, conn} <- SpeciesApp.Auth.login(conn, user) do
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: specie_path(conn, :index))
    else
      _ ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> SpeciesApp.Auth.logout()
    |> redirect(to: session_path(conn, :new))
  end
end
