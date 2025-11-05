defmodule Action do
  @callback perform(props :: Dict) :: List
end
