defmodule Data.Repo.Migrations.CreateAccountTbl do
  use Ecto.Migration
  @moduledoc false

  def up do
    create table(:accounts, primary_key: false) do
      add :code, :string, primary_key: true
      add :name, :string
      add :status, :string
      add :effective_date, :date
      add :expiry_date, :date

      timestamps()
    end
  end

  def down do
    drop table(:accounts)
  end
end
