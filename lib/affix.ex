defmodule Affix do
  def build(files, include_dirs, output, libs) do
    cc_flags = %CcFlags{include_dirs: include_dirs, no_link?: true}
    cc = %Cc{executable: "gcc", flags: cc_flags}

    unlinked_files = Enum.map(files, fn file -> compile_file(file, cc) end)
    
    linker_flags = %CcLinkerFlags{output: output, link_libs: libs}
    cc_linker = %CcLinker{executable: "gcc", flags: linker_flags}

    linker_flags = LinkerFlags.libs(cc_linker.flags) ++ LinkerFlags.output_name(cc_linker.flags)
    Linker.link(cc_linker, unlinked_files, linker_flags) 
  end

  defp compile_file(file, cc) do
    output_name = file <> ".o"
    file_flags = %{cc.flags | output: output_name}
    cc_flags = CompilerFlags.output_name(file_flags) ++ CompilerFlags.no_link(file_flags) ++ CompilerFlags.include_dirs(file_flags)
    Compiler.compile(cc, [file], cc_flags)

    output_name 
  end
end
