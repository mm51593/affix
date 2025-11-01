defmodule Affix do
  def run(recipe_path) do
    recipe = %Recipe{path: recipe_path}
    yaml = Recipe.read_recipe(recipe)
    Enum.map(yaml["build"], &Build.run_build(Recipe.atomize_keys(&1)))
  end
end
