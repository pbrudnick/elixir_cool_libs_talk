defmodule SpeciesApp.Repo.Migrations.AddSongFieldForSpecies do
  use Ecto.Migration

  def change do
    alter table("species") do
      add :song, :string
    end
  end
end
