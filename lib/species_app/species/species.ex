defmodule SpeciesApp.Species do
  @moduledoc """
  The Species context.
  """

  import Ecto.Query, warn: false
  require Logger
  alias SpeciesApp.Repo
  alias SpeciesApp.Species.Specie

  @retry_errors [
    # TIMEOUT
    408,
    # RESOURCE_EXHAUSTED
    429,
    # CANCELLED
    499,
    # INTERNAL
    500,
    # BAD_GATEWAY
    502,
    # UNAVAILABLE
    503,
    # DEADLINE_EXCEEDED
    504
  ]
  @retry_opts %ExternalService.RetryOptions{
    backoff: {:exponential, 500},
    # Stop retrying after 10 seconds.
    expiry: 10_000
  }

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

  @doc """
  Returns the list of species from cache and if not present, from the DB.

  ## Examples

      iex> get_all_maybe_from_cache()
      [%Specie{}, ...]

  """
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

  @doc """
  Gets a single specie from cache, if not present in cache, from DB.

  Raises `Ecto.NoResultsError` if the Specie does not exist.

  ## Examples

      iex> get_one_maybe_from_cache!(123)
      %Specie{}

      iex> get_one_maybe_from_cache!(456)
      ** (Ecto.NoResultsError)

  """
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
  Gets the recent observations of a specie in Argentina.
  It requests an external API and uses `ExternalService` as a circuit breaker strategy

  Raises `Ecto.NoResultsError` if the Specie does not exist.
  """
  def get_observations(id) do
    specie = get_specie!(id)
    case ExternalService.call(:observations_fuse, @retry_opts, fn -> try_get_observations(specie, "AR") end) do
      {:ok, %{status_code: 404}} ->
        Logger.error("get_observations from ebird return 404")
        []

      {:ok, %{status_code: status_code, body: body}} when status_code in 200..299 ->
        body |> Jason.decode!

      {:error, {:retries_exhausted, _reason}} ->
        Logger.error("get_observations from ebird return :retries_exhausted")
        # do something..
        []

      {:error, {:fuse_blown, _fuse_name}} ->
        Logger.error("get_observations from ebird return :fuse_blown")
        # do something..
        []

      error ->
        Logger.error("get_observations from ebird return an error #{inspect(error)}")
        # do something..
        []
    end
  end

  @doc false
  defp try_get_observations(%Specie{ebird_id: ebird_id}, region_code) do
    url = "https://ebird.org/ws2.0/data/obs/#{region_code}/recent/#{ebird_id}"
    headers = [
      "X-eBirdApiToken": System.get_env("EBIRD_API_TOKEN")
    ]

    Logger.debug("requesting ebird observations to url=#{url}")

    HTTPoison.get(url, headers, [{"Content-Type", "application/json"}])
    |> case do
      {:ok, %{status_code: status_code}} when status_code in @retry_errors ->
        Logger.info("retrying get with ExternalService circuit breaker to #{url} after status code #{status_code}..")
        {:retry, status_code}

      {:error, %{reason: :connect_timeout}} ->
        Logger.info("retrying get with ExternalService circuit breaker to #{url} after connect_timeout..")
        {:retry, :connect_timeout}

      result ->
        result
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
