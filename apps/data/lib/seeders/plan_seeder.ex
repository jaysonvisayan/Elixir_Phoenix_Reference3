defmodule Data.Seeders.PlanSeeder do
  @moduledoc false

  alias Data.Contexts.PlanContext

  def seed(data) do
    Enum.map(data, fn(params) ->
      case PlanContext.insert_plan_seed(params) do
        {:ok, skipping} ->
          skipping
      end
    end)
  end
end
