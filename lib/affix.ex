defmodule Affix do
  def run(recipe_path) do
    recipe = %Recipe{path: recipe_path}
    yaml = Recipe.read_recipe(recipe)
    Enum.map(yaml["build"], &Build.run_build(Build.from_map(&1)))
  end
end
