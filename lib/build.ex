defmodule Build do
  defstruct [
    :target,
    :src,
    :include,
    :cc,
    :libs
  ]

  def run_build(build) do
    build[:src]
    |> Enum.map(fn file -> compile_file(file, build) end)
    |> link(build)
  end

  defp compile_file(src_file, props) do
    output_name = Path.rootname(src_file) <> ".o"
    props = %{props | src: src_file, target: output_name}

    Cc.compile(props)

    output_name
  end

  defp link(obj_files, props) do
    props = %{props | src: obj_files}

    CcLinker.link(props)
  end
end
