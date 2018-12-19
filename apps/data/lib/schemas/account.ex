defmodule Data.Schemas.Account do
  @moduledoc false
  use Data.Schema

  @primary_key {:code, :string, []}
  schema "accounts" do
    field :name, :string
    field :status, :string
    field :effective_date, :date
    field :expiry_date, :date

    has_many :account_plans, Data.Schemas.AccountPlan, on_delete: :delete_all, foreign_key: :account_code
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :code,
      :name,
      :status,
      :effective_date,
      :expiry_date
    ])
  end

end
