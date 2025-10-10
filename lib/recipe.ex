defmodule Recipe do
  defstruct [:path]

  def read_recipe(recipe) do
    {:ok, yaml} = YamlElixir.read_from_file(recipe.path)
    yaml
  end

  def atomize_keys(map) do
    Enum.map(map, fn {k, v} -> {String.to_existing_atom(k), v} end) |> Map.new()
  end
end
