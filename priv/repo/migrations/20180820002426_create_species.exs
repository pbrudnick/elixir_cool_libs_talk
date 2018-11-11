defmodule SpeciesApp.Repo.Migrations.CreateSpecies do
  use Ecto.Migration

  def change do
    create table(:species, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name_es, :string
      add :name_en, :string
      add :name_pt, :string
      add :sci_name, :string
      add :picture, :string
      add :active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
