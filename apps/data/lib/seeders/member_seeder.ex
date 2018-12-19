defmodule Data.Seeders.MemberSeeder do
  @moduledoc false

  alias Data.Contexts.MemberContext

  def seed(data) do
    Enum.map(data, fn(params) ->
      case MemberContext.insert_member_seed(params) do
        {:ok, m} ->
          m
      end
    end)
  end
end

