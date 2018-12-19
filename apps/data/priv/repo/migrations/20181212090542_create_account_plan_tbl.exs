defmodule Data.Repo.Migrations.CreateAccountPlanTbl do
  use Ecto.Migration

  def up do
    create table(:account_plans, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :account_code, references(:accounts, column: :code, type: :string, on_delete: :delete_all)
      add :plan_code, references(:plans, column: :code, type: :string, on_delete: :delete_all)

      timestamps()
    end
  end

  def down do
    drop table(:account_plans)
  end
end
