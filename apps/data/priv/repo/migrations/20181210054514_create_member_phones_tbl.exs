defmodule Data.Repo.Migrations.CreateMemberPhonesTbl do
  use Ecto.Migration

  def up do
    create table(:member_phones, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string
      add :country_code, :string
      add :area_code, :integer
      add :number, :integer
      add :local, :integer

      add :member_id, references(:members, column: :member_id, type: :string, on_delete: :delete_all)
    end
  end

  def down do
    drop table(:member_phones)
  end
end
