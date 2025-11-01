defmodule Compiler do
  @callback compile(props :: Map) :: Integer
  @callback preprocess(props :: Map) :: Integer
end

