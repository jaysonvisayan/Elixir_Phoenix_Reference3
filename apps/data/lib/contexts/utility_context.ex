defmodule Data.Contexts.UtilityContext do
  @moduledoc false

  def transform_error_message(changeset) do
    errors = Enum.map(changeset.errors, fn({key, {message, _}}) ->
      %{
        "#{key}" => "#{key} #{message}"
      }
    end)

    Enum.reduce(errors, fn(head, tail) ->
      Map.merge(head, tail)
    end)
  end

end
