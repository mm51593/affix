defmodule Cc do
  defstruct [:executable]
  @behaviour Compiler

  def compile(compiler, src_files, flags) do
    {_, exit_code} = Shell.exec(compiler.executable, src_files ++ flags)
    exit_code
  end

  def preprocess(compiler, src_files, flags) do
    {_, exit_code} = Shell.exec(compiler.executable, ["-E" | src_files ++ flags])
    exit_code
  end
end
