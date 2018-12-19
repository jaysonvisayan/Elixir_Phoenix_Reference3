defmodule Data.Schemas.Member do
  @moduledoc false
  use Data.Schema

  @primary_key {:member_id, :string, []}
  schema "members" do
    field :step, :string
    field :status, :string
    field :version, :string
    field :card_no, :string
    field :policy_no, :string
    field :photo, :string
    field :is_waive_enrollment, :boolean
    field :account_code, :string
    field :member_type, :string
    field :principal_member_id, :string
    field :principal_plan_code, :string
    field :relationship, :string
    field :effective_date, :date
    field :expiry_date, :date
    field :is_mononymous, :boolean
    field :first_name, :string
    field :middle_name, :string
    field :last_name, :string
    field :suffix, :string
    field :gender, :string
    field :civil_status, :string
    field :birth_date, :date
    field :employee_no, :string
    field :hired_date, :date
    field :regularization_date, :date
    field :tin, :string
    field :is_for_card_issuance, :boolean
    field :is_member_vip, :boolean
    field :is_senior_citizen, :boolean
    field :senior_id_no, :integer
    field :senior_id_photo, :string
    field :is_pwd, :boolean
    field :pwd_id_no, :integer
    field :pwd_id_photo, :string
    field :philhealth, :string
    field :philhealth_no, :integer
    field :plan_codes, {:array, :string}
    field :email, :string
    field :email2, :string
    field :address_line1, :string
    field :address_line2, :string
    field :city, :string
    field :province, :string
    field :region, :string
    field :country, :string
    field :postal_code, :integer

    has_many :member_skipping_hierarchy, Data.Schemas.MemberSkippingHierarchy, on_delete: :delete_all
    has_many :member_phones, Data.Schemas.MemberPhone, on_delete: :delete_all

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
        :step,
        :status,
        :member_id,
        :first_name,
        :middle_name,
        :last_name,
        :account_code,
        :plan_codes,
        :suffix
      ]
    )
    |> validate_required(
      [
        :member_id
      ]
    )
  end
end
