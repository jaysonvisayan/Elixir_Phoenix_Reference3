defmodule Data.Seeders.MemberSkippingHierarchySeeder do
  @moduledoc false

  alias Data.Contexts.MemberSkippingHierarchyContext

  def seed(data) do
    Enum.map(data, fn(params) ->
      case MemberSkippingHierarchyContext.insert_skipping_hierarchy_seed(params) do
        {:ok, skipping} ->
          skipping
      end
    end)
  end
end
