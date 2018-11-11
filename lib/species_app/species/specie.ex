defmodule SpeciesApp.Species.Specie do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "species" do
    field :active, :boolean, default: false
    field :name_en, :string
    field :name_es, :string
    field :name_pt, :string
    field :picture, :string
    field :sci_name, :string
    field :regions, {:array, :string}
    field :status,    :string
    field :difficulty, :integer
    field :song, :string

    timestamps()
  end

  @doc false
  def changeset(specie, attrs) do
    specie
    |> cast(attrs, [:name_es, :name_en, :name_pt, :sci_name, :picture, :active, :regions, :status, :difficulty, :song])
    |> validate_required([:name_es, :name_en, :name_pt, :sci_name, :picture, :active])
  end
end
