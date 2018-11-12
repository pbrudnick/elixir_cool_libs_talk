defmodule SpeciesAppWeb.SpecieView do
  use SpeciesAppWeb, :view
  alias SpeciesAppWeb.SpecieView

  def render("index.json", %{species: species}) do
    %{species: render_many(species, SpecieView, "specie.json")}
  end

  def render("specie.json", %{specie: specie}) do
    %{
      id: specie.id,
      name_es: specie.name_es,
      name_en: specie.name_en,
      name_pt: specie.name_pt,
      sci_name: specie.sci_name,
      picture: specie.picture,
      regions: specie.regions,
      status: specie.status,
      difficulty: specie.difficulty,
      song: specie.song,
      ebird_id: specie.ebird_id
    }
  end

  def render("observations.json", %{observations: observations}) do
    %{observations: observations}
  end
end
