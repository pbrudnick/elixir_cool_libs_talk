defmodule SpeciesAppWeb.SpecieControllerTest do
  use SpeciesAppWeb.ConnCase

  alias SpeciesApp.Species

  @create_attrs %{active: true, name_en: "some name_en", name_es: "some name_es", name_pt: "some name_pt", picture: "some picture", sci_name: "some sci_name"}
  @update_attrs %{active: false, name_en: "some updated name_en", name_es: "some updated name_es", name_pt: "some updated name_pt", picture: "some updated picture", sci_name: "some updated sci_name"}
  @invalid_attrs %{active: nil, name_en: nil, name_es: nil, name_pt: nil, picture: nil, sci_name: nil}

  def fixture(:specie) do
    {:ok, specie} = Species.create_specie(@create_attrs)
    specie
  end

  describe "index" do
    test "lists all species", %{conn: conn} do
      conn = get conn, specie_path(conn, :index)
      assert html_response(conn, 200) =~ "Listado de Especies"
    end
  end

  describe "new specie" do
    test "renders form", %{conn: conn} do
      conn = get conn, specie_path(conn, :new)
      assert html_response(conn, 200) =~ "New Specie"
    end
  end

  describe "create specie" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, specie_path(conn, :create), specie: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == specie_path(conn, :show, id)

      conn = get conn, specie_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Ficha de especie"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, specie_path(conn, :create), specie: @invalid_attrs
      assert html_response(conn, 200) =~ "New Specie"
    end
  end

  describe "edit specie" do
    setup [:create_specie]

    test "renders form for editing chosen specie", %{conn: conn, specie: specie} do
      conn = get conn, specie_path(conn, :edit, specie)
      assert html_response(conn, 200) =~ "Edit Specie"
    end
  end

  describe "update specie" do
    setup [:create_specie]

    test "redirects when data is valid", %{conn: conn, specie: specie} do
      conn = put conn, specie_path(conn, :update, specie), specie: @update_attrs
      assert redirected_to(conn) == specie_path(conn, :show, specie)

      conn = get conn, specie_path(conn, :show, specie)
      assert html_response(conn, 200) =~ "some updated name_en"
    end

    test "renders errors when data is invalid", %{conn: conn, specie: specie} do
      conn = put conn, specie_path(conn, :update, specie), specie: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Specie"
    end
  end

  describe "delete specie" do
    setup [:create_specie]

    test "deletes chosen specie", %{conn: conn, specie: specie} do
      conn = delete conn, specie_path(conn, :delete, specie)
      assert redirected_to(conn) == specie_path(conn, :index)
    end
  end

  defp create_specie(_) do
    specie = fixture(:specie)
    {:ok, specie: specie}
  end
end
