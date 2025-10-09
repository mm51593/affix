defmodule Ccflags do
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

defimpl Flags, for: Ccflags do
  def include_dirs(ccflags) do
    Enum.flat_map(
      ccflags.include_dirs,
      fn x -> [Ccflags.include_flag(), x] end
    )
  end

  def output_name(ccflags) do
    case ccflags.output do
      "" -> []
      _ -> [Ccflags.output_flag(), ccflags.output]
    end
  end

  def no_link(ccflags) do
    case ccflags.no_link? do
      true -> [Ccflags.no_link_flag()]
      false -> []
    end
  end
end
