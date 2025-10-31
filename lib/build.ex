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
    cc_flags = %CcFlags{
      flag_include: build.include,
    }

    cc = %Cc{executable: build.cc}

    Enum.map(build.src, &compile_file(&1, cc, cc_flags))
  end

  defp compile_file(src_file, cc, cc_flags) do
    output_name = Path.rootname(src_file) <> ".o"
    cc_flags = CcFlags.render(%{cc_flags | flag_output: output_name})

    Cc.compile(cc, [src_file], cc_flags)

    output_name
  end

  defp link(build, obj_files) do
    linker_flags = %CcLinkerFlags{
      flag_output: build.target,
      flag_libs: build.libs
    }

    cc_linker = %CcLinker{executable: build.cc}

    linker_flags = CcLinkerFlags.render(linker_flags)

    CcLinker.link(cc_linker, obj_files, linker_flags)
  end
end
