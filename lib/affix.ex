defmodule Affix do
  def build(files, include_dirs, output) do
    ccflags = %Ccflags{include_dirs: include_dirs, output: output}
    cc = %Cc{executable: "gcc", flags: ccflags}

    flags = Flags.output_name(ccflags) ++ Flags.include_dirs(cc.flags)
    Compiler.compile(cc, files, flags)
  end
end
