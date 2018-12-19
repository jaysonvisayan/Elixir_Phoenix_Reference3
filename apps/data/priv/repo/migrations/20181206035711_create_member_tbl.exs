defmodule Data.Repo.Migrations.CreateMemberTbl do
  use Ecto.Migration

  def up do
    create table(:members, primary_key: false) do
      add :step, :string
      add :status, :string
      add :version, :string
      add :member_id, :string, primary_key: true
      add :card_no, :string
      add :policy_no, :string
      add :photo, :string
      add :is_waive_enrollment, :boolean
      add :account_code, :string
      add :member_type, :string
      add :principal_member_id, :string
      add :principal_plan_code, :string
      add :relationship, :string
      add :effective_date, :date
      add :expiry_date, :date
      add :is_mononymous, :boolean
      add :first_name, :string
      add :middle_name, :string
      add :last_name, :string
      add :suffix, :string
      add :gender, :string
      add :civil_status, :string
      add :birth_date, :date
      add :employee_no, :string
      add :hired_date, :date
      add :regularization_date, :date
      add :tin, :string
      add :is_for_card_issuance, :boolean
      add :is_member_vip, :boolean
      add :is_senior_citizen, :boolean
      add :senior_id_no, :integer
      add :senior_id_photo, :string
      add :is_pwd, :boolean
      add :pwd_id_no, :integer
      add :pwd_id_photo, :string
      add :philhealth, :string
      add :philhealth_no, :integer
      add :plan_codes, {:array, :string}
      add :email, :string
      add :email2, :string
      add :address_line1, :string
      add :address_line2, :string
      add :city, :string
      add :province, :string
      add :region, :string
      add :country, :string
      add :postal_code, :integer
      add :inserted_by, :string
      add :updated_by, :string

    timestamps()
    end
  end

  def down do
    drop table(:members)
  end
end
