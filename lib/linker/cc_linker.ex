defmodule CcLinker do
  defstruct [:executable, :flags]
end

defimpl Linker, for: CcLinker do
  def link(linker, obj_files, flags) do
    {_, exit_code} = Shell.exec(linker.executable, obj_files ++ flags)
    exit_code
  end
end
