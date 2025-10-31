defmodule Compiler do
  @callback compile(compiler :: Compiler, src_files :: List, flags :: List) :: Integer
  @callback preprocess(compiler :: Compiler, src_files :: List, flags :: List) :: Integer
end

