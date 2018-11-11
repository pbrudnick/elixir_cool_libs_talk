defmodule SpeciesApp.SpeciesTest do
  use SpeciesApp.DataCase

  alias SpeciesApp.Species

  describe "species" do
    alias SpeciesApp.Species.Specie

    @valid_attrs %{active: true, name_en: "some name_en", name_es: "some name_es", name_pt: "some name_pt", picture: "some picture", sci_name: "some sci_name"}
    @update_attrs %{active: false, name_en: "some updated name_en", name_es: "some updated name_es", name_pt: "some updated name_pt", picture: "some updated picture", sci_name: "some updated sci_name"}
    @invalid_attrs %{active: nil, name_en: nil, name_es: nil, name_pt: nil, picture: nil, sci_name: nil}

    def specie_fixture(attrs \\ %{}) do
      {:ok, specie} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Species.create_specie()

      specie
    end

    test "list_species/0 returns all species" do
      specie = specie_fixture()
      assert Species.list_species() == [specie]
    end

    test "get_specie!/1 returns the specie with given id" do
      specie = specie_fixture()
      assert Species.get_specie!(specie.id) == specie
    end

    test "create_specie/1 with valid data creates a specie" do
      assert {:ok, %Specie{} = specie} = Species.create_specie(@valid_attrs)
      assert specie.active == true
      assert specie.name_en == "some name_en"
      assert specie.name_es == "some name_es"
      assert specie.name_pt == "some name_pt"
      assert specie.picture == "some picture"
      assert specie.sci_name == "some sci_name"
    end

    test "create_specie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Species.create_specie(@invalid_attrs)
    end

    test "update_specie/2 with valid data updates the specie" do
      specie = specie_fixture()
      assert {:ok, specie} = Species.update_specie(specie, @update_attrs)
      assert %Specie{} = specie
      assert specie.active == false
      assert specie.name_en == "some updated name_en"
      assert specie.name_es == "some updated name_es"
      assert specie.name_pt == "some updated name_pt"
      assert specie.picture == "some updated picture"
      assert specie.sci_name == "some updated sci_name"
    end

    test "update_specie/2 with invalid data returns error changeset" do
      specie = specie_fixture()
      assert {:error, %Ecto.Changeset{}} = Species.update_specie(specie, @invalid_attrs)
      assert specie == Species.get_specie!(specie.id)
    end

    test "delete_specie/1 deletes the specie" do
      specie = specie_fixture()
      assert {:ok, %Specie{}} = Species.delete_specie(specie)
      assert_raise Ecto.NoResultsError, fn -> Species.get_specie!(specie.id) end
    end

    test "change_specie/1 returns a specie changeset" do
      specie = specie_fixture()
      assert %Ecto.Changeset{} = Species.change_specie(specie)
    end
  end
end
