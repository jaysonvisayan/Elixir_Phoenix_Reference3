defmodule Data.Seeders.ClinicTest do
  @moduledoc false

  use Data.SchemaCase
  alias Data.Seeders.Clinic, as: SC

  @tag :unit
  describe "seed clinic" do
    test "with new clinic" do
      code = "1234"
      [c] = SC.seed([data(code)])
      assert c.code == code
    end

    test "update existing clinic" do
      code = "1234"
      c = insert(:clinic, code: code)

      [c] = SC.seed([data(code)])
      assert c.code == code
    end
  end

  defp data(code) do
    %{
      code: code,
      name: Faker.Name.title(),
      description: Faker.Lorem.paragraph()
    }
  end
end
