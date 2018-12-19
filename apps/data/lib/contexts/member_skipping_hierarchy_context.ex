defmodule Data.Contexts.MemberSkippingHierarchyContext do
  @moduledoc false

  alias Data.{
    Repo,
    Schemas.MemberSkippingHierarchy
  }

  # For seed

 def insert_skipping_hierarchy_seed(params) do
    params
    |> skipping_get_by()
    |> create_update_skipping(params)
  end

  defp create_update_skipping(nil, params) do
    %MemberSkippingHierarchy{}
    |> MemberSkippingHierarchy.changeset(params)
    |> Repo.insert()
  end

  defp create_update_skipping(skipping, params) do
    skipping
    |> MemberSkippingHierarchy.changeset(params)
    |> Repo.update()
  end

  defp skipping_get_by(params) do
    MemberSkippingHierarchy|> Repo.get_by(params)
  end
end
