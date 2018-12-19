defmodule Data.Contexts.MemberPlanContext do
  @moduledoc false

  alias Data.{
    Repo,
    Schemas.MemberPlan
  }

  # For seed

 def insert_member_plan_seed(params) do
    params
    |> plan_get_by()
    |> create_update_plan(params)
  end

  defp create_update_plan(nil, params) do
    %MemberPlan{}
    |> MemberPlan.changeset(params)
    |> Repo.insert()
  end

  defp create_update_plan(plan, params) do
    plan
    |> MemberPlan.changeset(params)
    |> Repo.update()
  end

  defp plan_get_by(params) do
    MemberPlan |> Repo.get_by(params)
  end
end
