defmodule Data.Schemas.AccountPlan do
  @moduledoc false
  use Data.Schema

  @foreign_key_type :string
  schema "account_plans" do

    belongs_to :accounts, Data.Schemas.Account, foreign_key: :account_code
    belongs_to :plans, Data.Schemas.Plan, foreign_key: :plan_code

    timestamps()
  end

end
