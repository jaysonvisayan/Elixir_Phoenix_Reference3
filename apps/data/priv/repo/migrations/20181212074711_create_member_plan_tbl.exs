defmodule Data.Repo.Migrations.CreateMemberPlanTbl do
  use Ecto.Migration

  def up do
    create table(:member_plan, primary_key: false) do
      add :tier, :string
      add :code, :string, primary_key: true
      add :name, :string
      add :no_of_benefits, :string
      add :limit_type, :string
      add :limit_amount, :string

      add :member_id, references(:members, column: :member_id, type: :string, on_delete: :delete_all)
      add :plan_code, references(:plans, column: :code, type: :string, on_delete: :delete_all)

      timestamps()
    end
  end

  def down do
    drop table(:member_plan)
  end
end
