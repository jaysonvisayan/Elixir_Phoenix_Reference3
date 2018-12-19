defmodule Data.Seeders.MemberPhoneSeeder do
  @moduledoc false

  alias Data.Contexts.MemberPhoneContext

  def seed(data) do
    Enum.map(data, fn(params) ->
      case MemberPhoneContext.insert_member_phone_seed(params) do
        {:ok, p} ->
          p
      end
    end)
  end
end
