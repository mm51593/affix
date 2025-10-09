defmodule Cc do
  defstruct [:executable, :flags]
end

defimpl Compiler, for: Cc do
  def compile(compiler, files, flags) do
    {_, exit_code} = Shell.exec(compiler.executable, files ++ flags)
    exit_code
  end

  def preprocess(compiler, files, flags) do
    {_, exit_code} = Shell.exec(compiler.executable, ["-E" | files ++ flags])
    exit_code
  end
end
