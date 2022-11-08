defmodule Rockelivery.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:address, :age, :zip_code, :document_number, :email, :password, :name]
  @derive {Jason.Encoder, only: [:id, :age, :document_number, :address, :email, :name]}

  schema "users" do
    field :address, :string
    field :age, :integer
    field :zip_code, :string
    field :document_number, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password_hash, min: 6)
    |> validate_length(:zip_code, is: 8)
    |> validate_length(:document_number, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:document_number])
    |> put_password_hash()
  end

  defp put_password_hash(
         %Changeset{valid?: true, changes: %{password: password}} = change_set
       ) do
    change(change_set, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
