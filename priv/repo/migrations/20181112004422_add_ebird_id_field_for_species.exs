defmodule SpeciesApp.Repo.Migrations.AddEbirdIdFieldForSpecies do
  use Ecto.Migration

  def change do
    alter table("species") do
      add :ebird_id, :string
    end
  end
end
