defmodule Data.Contexts.GenericLookUpContext do
  @moduledoc false
  alias Data.{
    Schemas.GenericLookUp,
    Repo
  }

  def insert_generic_look_up_seed(params) do
    params
    |> get_generic_look_up()
    |> create_update_generic_look_up(params)
  end

  defp create_update_generic_look_up(generic_look_up, params) when is_nil(generic_look_up) do
    %GenericLookUp{}
    |> GenericLookUp.changeset(params)
    |> Repo.insert()
  end

  defp create_update_generic_look_up(generic_look_up, params) do
    generic_look_up
    |> GenericLookUp.changeset(params)
    |> Repo.update()
  end

  def get_generic_look_up(params) do
    GenericLookUp
    |> Repo.get_by(code: params.code)
  end
 
end
