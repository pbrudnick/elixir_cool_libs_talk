defmodule SpeciesApp.Species.Warmer do
  @moduledoc """
  Module to warm the packages API.
  """
  use Cachex.Warmer
  alias SpeciesApp.Repo
  alias SpeciesApp.Species.Specie

  @doc """
  Returns the interval for this warmer.
  """
  def interval,
    do: :timer.seconds(20)

  @doc """
  Executes this cache warmer with a connection.
  """
  def execute(_state) do
    # load all of the packages from the database
    species = Repo.all(Specie)

    # create pairs from the API path and the package
    specie_pairs = Enum.map(species, fn(specie) ->
      { "/api/species/#{specie.id}", specie }
    end)

    # return pairs for the root, as well as all single packages
    { :ok, [ { "/api/species", species } | specie_pairs ] }
  end
end
