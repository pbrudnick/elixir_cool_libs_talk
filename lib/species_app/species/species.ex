defmodule SpeciesApp.Species do
  @moduledoc """
  The Species context.
  """

  import Ecto.Query, warn: false
  alias SpeciesApp.Repo

  alias SpeciesApp.Species.Specie

  @doc """
  Returns the list of species.

  ## Examples

      iex> list_species()
      [%Specie{}, ...]

  """
  def list_species do
    Repo.all(Specie)
  end

  def list_species(%{matching: name}) when is_binary(name) do
    Specie
    |> where([m], ilike(m.name_es, ^"%#{name}%"))
    |> Repo.all
  end
  def list_species(_) do
    Repo.all(Specie)
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
  def get_specie!(id), do: Repo.get!(Specie, id)

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
