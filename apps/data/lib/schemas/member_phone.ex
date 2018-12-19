defmodule Data.Schemas.MemberPhone do
  @moduledoc false
  use Data.Schema

  @foreign_key_type :string
  schema "member_phones" do
    field :type, :string
    field :country_code, :string
    field :area_code, :integer
    field :number, :integer
    field :local, :integer

    belongs_to :member, Data.Schemas.Member, foreign_key: :member_id
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
        :type,
        :country_code,
        :area_code,
        :number,
        :member_id,
        :local
      ]
    )
  end
end
