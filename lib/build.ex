defmodule Build do
  defstruct [
    :target,
    :src,
    :include,
    :cc,
    :libs
  ]

  def from_map(map) do
    struct(Build, Recipe.atomize_keys(map))
  end

  def run_build(build) do
    obj_files = compile(build)
    link(build, obj_files)
  end

  defp compile(build) do
    cc_flags =
      CcFlags.new(%{
        flag_include: build.include,
        flag_output: nil,
        flag_no_link?: true
      })

    cc = %Cc{executable: build.cc, flags: cc_flags}

    Enum.map(build.src, &compile_file(&1, cc))
  end

  defp compile_file(src_file, cc) do
    output_name = src_file <> ".o"
    cc_flags = CcFlags.render(%{cc.flags | flag_output: output_name})

    Compiler.compile(cc, [src_file], cc_flags)

    output_name
  end

  defp link(build, obj_files) do
    linker_flags =
      CcLinkerFlags.new(%{
        flag_output: build.target,
        flag_libs: build.libs
      })

    cc_linker = %CcLinker{executable: build.cc, flags: linker_flags}

    linker_flags = CcLinkerFlags.render(linker_flags)

    Linker.link(cc_linker, obj_files, linker_flags)
  end
end
