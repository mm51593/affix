defmodule Linker do
  @callback link(linker :: Linker, obj_files :: List, flags :: List) :: Integer
end
