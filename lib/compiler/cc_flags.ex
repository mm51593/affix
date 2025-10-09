defmodule CcFlags do
  defstruct [:include_dirs, :output, :no_link?]

  def include_flag do
    "-I"
  end

  def output_flag do
    "-o"
  end

  def no_link_flag do
    "-c"
  end
end

defimpl CompilerFlags, for: CcFlags do
  def include_dirs(cc_flags) do
    Enum.flat_map(
      cc_flags.include_dirs,
      fn x -> [CcFlags.include_flag(), x] end
    )
  end

  def output_name(cc_flags) do
    case cc_flags.output do
      "" -> []
      _ -> [CcFlags.output_flag(), cc_flags.output]
    end
  end

  def no_link(cc_flags) do
    case cc_flags.no_link? do
      true -> [CcFlags.no_link_flag()]
      false -> []
    end
  end
end
