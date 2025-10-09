defmodule CcLinkerFlags do
  defstruct [:output, :link_libs]

  def output_flag do
    "-o"
  end

  def lib_flag do
    "-l"
  end
end

defimpl LinkerFlags, for: CcLinkerFlags do
  def libs(cc_linker_flags) do
    Enum.flat_map(
      cc_linker_flags.link_libs,
      fn x -> [CcLinkerFlags.lib_flag(), x] end
    )
  end

  def output_name(cc_linker_flags) do
    case cc_linker_flags.output do
      "" -> []
      _ -> [CcLinkerFlags.output_flag(), cc_linker_flags.output]
    end
  end
end
