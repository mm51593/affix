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
  def libs(cclinkerflags) do
    Enum.flat_map(
      cclinkerflags.link_libs,
      fn x -> [CcLinkerFlags.lib_flag(), x] end
    )
  end

  def output_name(cclinkerflags) do
    case cclinkerflags.output do
      "" -> []
      _ -> [CcLinkerFlags.output_flag(), cclinkerflags.output]
    end
  end
end
