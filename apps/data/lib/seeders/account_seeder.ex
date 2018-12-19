defmodule Data.Seeders.AccountSeeder do
  @moduledoc false

  alias Data.Contexts.AccountContext

  def seed(data) do
    Enum.map(data, fn(params) ->
      case AccountContext.insert_account_seed(params) do
        {:ok, a} ->
          a
      end
    end)
  end
end
