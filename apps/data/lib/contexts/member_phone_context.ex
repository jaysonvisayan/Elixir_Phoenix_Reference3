defmodule Data.Contexts.MemberPhoneContext do
  @moduledoc false

  alias Data.{
    Repo,
    Schemas.MemberPhone
  }

  # For seed

 def insert_member_phone_seed(params) do
    params
    |> phone_get_by()
    |> create_update_phone(params)
  end

  defp create_update_phone(nil, params) do
    %MemberPhone{}
    |> MemberPhone.changeset(params)
    |> Repo.insert()
  end

  defp create_update_phone(phone, params) do
    phone
    |> MemberPhone.changeset(params)
    |> Repo.update()
  end

  defp phone_get_by(params) do
    MemberPhone |> Repo.get_by(params)
  end
end
