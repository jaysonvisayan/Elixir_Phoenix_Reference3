defmodule Data.Repo.Migrations.CreateMemberSkippingHierarchyTbl do
  use Ecto.Migration

  def up do
    create table(:member_skipping_hierarchy, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :relationship, :string
      add :first_name, :string
      add :middle_name, :string
      add :last_name, :string
      add :suffix, :string
      add :birth_date, :date
      add :reason, :string
      add :gender, :string
      add :supporting_docs, :string

      add :member_id, references(:members, column: :member_id, type: :string, on_delete: :delete_all)
    end
  end

  def down do
    drop table(:member_skipping_hierarchy)
  end
end
