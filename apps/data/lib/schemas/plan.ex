defmodule Data.Schemas.Plan do
  @moduledoc false
  use Data.Schema

  @primary_key {:code, :string, []}
  schema "plans" do
    field :name, :string
    field :limit_type, :string
    field :limit_amount, :integer
    field :no_of_benefits, :integer

    has_many :member, Data.Schemas.MemberPlan, on_delete: :delete_all

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
        :code,
        :name,
        :limit_amount,
        :no_of_benefits,
        :limit_type
      ]
    )
  end
end
