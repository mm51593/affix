defmodule CcLinker do
  defstruct [:executable]
  @behaviour Linker

  def link(linker, obj_files, flags) do
    {_, exit_code} = Shell.exec(linker.executable, obj_files ++ flags)
    exit_code
  end
end
