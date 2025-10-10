defmodule Build do
  defstruct [
    :target,
    :src,
    :include,
    :cc,
    :libs
  ]

  def from_map(map) do
    struct(Build, Recipe.atomize_keys(map))
  end
end
