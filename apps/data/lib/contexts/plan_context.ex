defmodule Data.Contexts.PlanContext do
  @moduledoc false

  alias Data.{
    Repo,
    Schemas.Plan
  }

  # For seed

 def insert_plan_seed(params) do
    params
    |> plan_get_by()
    |> create_update_plan(params)
  end

  defp create_update_plan(nil, params) do
    %Plan{}
    |> Plan.changeset(params)
    |> Repo.insert()
  end

  defp create_update_plan(plan, params) do
    plan
    |> Plan.changeset(params)
    |> Repo.update()
  end

  defp plan_get_by(params) do
    Plan |> Repo.get_by(params)
  end
end
