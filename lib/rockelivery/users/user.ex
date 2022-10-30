defmodule Rockelivery.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:address, :age, :zip_code, :document_number, :email, :password_hash, :name]

  schema "users" do
    field :address, :string
    field :age, :integer
    field :zip_code, :string
    field :document_number, :string
    field :email, :string
    field :password_hash, :string
    field :name, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
  end
end
