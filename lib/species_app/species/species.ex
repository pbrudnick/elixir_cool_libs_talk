defmodule SpeciesApp.Species do
  @moduledoc """
  The Species context.
  """

  import Ecto.Query, warn: false
  require Logger
  alias SpeciesApp.Repo
  alias SpeciesApp.Species.Specie

  @doc """
  Returns the list of species.

  ## Examples

      iex> list_species()
      [%Specie{}, ...]

  """
  def list_species do
    get_all_maybe_from_cache()
  end

  def list_species(%{matching: name}) when is_binary(name) do
    Specie
    |> where([m], ilike(m.name_es, ^"%#{name}%"))
    |> Repo.all
  end
  def list_species(_) do
    get_all_maybe_from_cache()
  end

  def get_all_maybe_from_cache() do
    case Cachex.get(:api_cache, "/api/species") do
      {:error, reason} ->
        Logger.error(
          "error on getting '/api/species' from api_cache with reason: #{
            inspect(reason)
          }"
        )

        Repo.all(Specie)
      {:ok, nil} ->
        Logger.info("getting species from db")

        Repo.all(Specie)
      {:ok, species} ->
        Logger.info("getting #{length(species)} species from api_cache")

        species
    end
  end

  def get_one_maybe_from_cache!(id) when is_binary(id) do
    case Cachex.get(:api_cache, "/api/species/#{id}") do
      {:error, reason} ->
        Logger.error(
          "error on getting '/api/specie/#{id}' from api_cache with reason: #{
            inspect(reason)
          }"
        )

        Repo.get!(Specie, id)
      {:ok, nil} ->
        Logger.info("getting specie #{id} from db")

        Repo.get!(Specie, id)
      {:ok, specie} ->
        Logger.info("getting specie #{id} from api_cache")

        specie
    end
  end

  @doc """
  Gets a single specie.

  Raises `Ecto.NoResultsError` if the Specie does not exist.

  ## Examples

      iex> get_specie!(123)
      %Specie{}

      iex> get_specie!(456)
      ** (Ecto.NoResultsError)

  """
  def get_specie!(id), do: get_one_maybe_from_cache!(id)

  @doc """
  Creates a specie.

  ## Examples

      iex> create_specie(%{field: value})
      {:ok, %Specie{}}

      iex> create_specie(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_specie(attrs \\ %{}) do
    %Specie{}
    |> Specie.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a specie.

  ## Examples

      iex> update_specie(specie, %{field: new_value})
      {:ok, %Specie{}}

      iex> update_specie(specie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_specie(%Specie{} = specie, attrs) do
    specie
    |> Specie.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Specie.

  ## Examples

      iex> delete_specie(specie)
      {:ok, %Specie{}}

      iex> delete_specie(specie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_specie(%Specie{} = specie) do
    Repo.delete(specie)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking specie changes.

  ## Examples

      iex> change_specie(specie)
      %Ecto.Changeset{source: %Specie{}}

  """
  def change_specie(%Specie{} = specie) do
    Specie.changeset(specie, %{})
  end
end
