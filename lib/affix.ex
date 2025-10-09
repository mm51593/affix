defmodule Affix do
  def build(files, include_dirs, output, no_link?) do
    ccflags = %Ccflags{include_dirs: include_dirs, output: output, no_link?: no_link?}
    cc = %Cc{executable: "gcc", flags: ccflags}

    flags = CompilerFlags.no_link(ccflags) ++ CompilerFlags.output_name(ccflags) ++ CompilerFlags.include_dirs(cc.flags)
    Compiler.compile(cc, files, flags)
  end
end
