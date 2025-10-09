defmodule Affix do
  def build(src_files, include_dirs, output, libs) do
    cc_flags = %CcFlags{include_dirs: include_dirs, no_link?: true}
    cc = %Cc{executable: "gcc", flags: cc_flags}

    obj_files = Enum.map(src_files, fn file -> compile_file(file, cc) end)
    
    linker_flags = %CcLinkerFlags{output: output, link_libs: libs}
    cc_linker = %CcLinker{executable: "gcc", flags: linker_flags}

    linker_flags = LinkerFlags.libs(cc_linker.flags) ++ LinkerFlags.output_name(cc_linker.flags)
    Linker.link(cc_linker, obj_files, linker_flags) 
  end

  defp compile_file(src_file, cc) do
    output_name = src_file <> ".o"
    file_flags = %{cc.flags | output: output_name}
    cc_flags = CompilerFlags.output_name(file_flags) ++ CompilerFlags.no_link(file_flags) ++ CompilerFlags.include_dirs(file_flags)
    Compiler.compile(cc, [src_file], cc_flags)

    output_name 
  end
end
