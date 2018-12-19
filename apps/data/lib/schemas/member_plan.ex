defmodule Data.Schemas.MemberPlan do
  @moduledoc false
  use Data.Schema

  @primary_key {:code, :string, []}
  @foreign_key_type :string
  schema "member_plan" do
      field :tier, :string
      field :name, :string
      field :no_of_benefits, :string
      field :limit_type, :string
      field :limit_amount, :string

    belongs_to :member, Data.Schemas.Member, foreign_key: :member_id
    belongs_to :plan, Data.Schemas.Plan, foreign_key: :plan_code

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
        :tier,
        :code,
        :member_id,
        :plan_code,
        :limit_type,
        :limit_amount,
        :name
      ]
    )
  end
end
