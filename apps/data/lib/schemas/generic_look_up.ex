defmodule Data.Schemas.GenericLookUp do
  @moduledoc false

  use Data.Schema

  @primary_key {:code, :string, []}
  @primary_key {:type, :string, []}
  schema "generic_look_ups" do
    field :code, :string
    field :name, :string
    field :description, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :code,
      :type,
      :name,
      :description
    ])
    |> validate_required([
      :code,
      :type,
      :name,
      :description
    ])
    |> unique_constraint(:code, message: "Generic look up code already exist!")
    |> unique_constraint(:type, message: "Generic look up type already exist!")
  end

end
