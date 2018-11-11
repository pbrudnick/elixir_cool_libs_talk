defmodule SpeciesApp.Auth do
  @moduledoc false
  import Ecto.Query

  require Logger

  alias SpeciesApp.Repo
  alias SpeciesApp.Accounts.User

  def authenticate_user(email, given_password) do
    query = from(u in User, where: u.email == ^email)

    Repo.one(query)
    |> check_password(given_password)
  end

  defp check_password(nil, _), do: {:error, "Incorrect email or password"}

  defp check_password(user, given_password) do
    case Bcrypt.verify_pass(given_password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, "Incorrect email or password"}
    end
  end

  def login(conn, user) do
    try do
      conn =
        conn
        |> SpeciesApp.Auth.Guardian.Plug.sign_in(user)
        |> Plug.Conn.assign(:current_user, user)
      {:ok, conn}
    rescue
      error ->
        Logger.error("error on login #{inspect(error)}")
        {:error, error}
    end
  end

  def logout(conn) do
    conn
    |> SpeciesApp.Auth.Guardian.Plug.sign_out()
  end
end
