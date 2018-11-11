defmodule SpeciesApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :is_admin, :boolean, default: false
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :password_hash, :is_admin])
    |> validate_required([:email, :name, :password_hash, :is_admin])
  end

  def registration_changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    #|> validate_length(:username, min: 3, max: 10)
    |> validate_length(:password, min: 5, max: 10)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
