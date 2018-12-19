defmodule Data.Schemas.MemberSkippingHierarchy do
  @moduledoc false
  use Data.Schema

  @foreign_key_type :string
  schema "member_skipping_hierarchy" do
    field :relationship, :string
    field :first_name, :string
    field :middle_name, :string
    field :last_name, :string
    field :suffix, :string
    field :birth_date, :date
    field :reason, :string
    field :gender, :string
    field :supporting_docs, :string

    belongs_to :member, Data.Schemas.Member, foreign_key: :member_id
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
        :relationship,
        :first_name,
        :birth_date,
        :reason,
        :middle_name,
        :last_name,
        :supporting_docs,
        :gender,
        :member_id,
        :suffix
      ]
    )
  end
end
