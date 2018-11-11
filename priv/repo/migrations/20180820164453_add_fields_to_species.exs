defmodule SpeciesApp.Repo.Migrations.AddFieldsToSpecies do
  use Ecto.Migration

  def change do
    alter table("species") do
      add :regions, {:array, :string}
      add :status,    :string
      add :difficulty, :integer
    end
  end
end
