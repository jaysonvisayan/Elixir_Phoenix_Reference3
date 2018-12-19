defmodule Data.Seeders.MemberPlanSeeder do
  @moduledoc false

  alias Data.Contexts.MemberPlanContext

  def seed(data) do
    Enum.map(data, fn(params) ->
      case MemberPlanContext.insert_member_plan_seed(params) do
        {:ok, p} ->
          p
      end
    end)
  end
end
