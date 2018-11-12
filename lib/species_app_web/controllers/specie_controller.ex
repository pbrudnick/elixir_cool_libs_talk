defmodule SpeciesAppWeb.SpecieController do
  use SpeciesAppWeb, :controller

  alias SpeciesApp.Species
  alias SpeciesApp.Species.Specie

  def index(conn, _params) do
    species = Species.list_species()
    render(conn, "index.html", species: species)
  end

  def index_json(conn, _params) do
    species = Species.list_species()
    render(conn, "index.json", species: species)
  end

  def new(conn, _params) do
    changeset = Species.change_specie(%Specie{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"specie" => specie_params}) do
    case Species.create_specie(specie_params) do
      {:ok, specie} ->
        conn
        |> put_flash(:info, "Specie created successfully.")
        |> redirect(to: specie_path(conn, :show, specie))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    specie = Species.get_specie!(id)
    render(conn, "show.html", specie: specie)
  end

  def show_json(conn, %{"id" => id}) do
    specie = Species.get_specie!(id)
    render(conn, "specie.json", specie: specie)
  end

  def observations_json(conn, %{"id" => id}) do
    observations = Species.get_observations(id)
    render(conn, "observations.json", observations: observations)
  end

  def edit(conn, %{"id" => id}) do
    specie = Species.get_specie!(id)
    changeset = Species.change_specie(specie)
    render(conn, "edit.html", specie: specie, changeset: changeset)
  end

  def update(conn, %{"id" => id, "specie" => specie_params}) do
    specie = Species.get_specie!(id)

    case Species.update_specie(specie, specie_params) do
      {:ok, specie} ->
        conn
        |> put_flash(:info, "Specie updated successfully.")
        |> redirect(to: specie_path(conn, :show, specie))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", specie: specie, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    specie = Species.get_specie!(id)
    {:ok, _specie} = Species.delete_specie(specie)

    conn
    |> put_flash(:info, "Specie deleted successfully.")
    |> redirect(to: specie_path(conn, :index))
  end
end
