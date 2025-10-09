defmodule Ccflags do
  defstruct [:include_dirs, :output]

  def include_flag do
    "-I"
  end

  def output_flag do
    "-o"
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
    [Ccflags.output_flag(), ccflags.output]
  end
end
