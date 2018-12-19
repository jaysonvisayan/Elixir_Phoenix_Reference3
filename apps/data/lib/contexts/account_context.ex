defmodule Data.Contexts.AccountContext do
  @moduledoc false

  alias Data.{
    Repo,
    Schemas.Account
  }

  # For seed

 def insert_account_seed(params) do
    params
    |> account_get_by()
    |> create_update_account(params)
  end

  defp create_update_account(nil, params) do
    %Account{}
    |> Account.changeset(params)
    |> Repo.insert()
  end

  defp create_update_account(account, params) do
    account
    |> Account.changeset(params)
    |> Repo.update()
  end

  defp account_get_by(params) do
    Account |> Repo.get_by(params)
  end
end
