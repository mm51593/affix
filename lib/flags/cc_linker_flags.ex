defmodule CcLinkerFlags do
  use FlagsBase

  defstruct [
    :flag_output,
    :flag_libs
  ]

  def get_switch(:flag_output), do: "-o"
  def get_switch(:flag_libs), do: "-l"

  def get_flags(cc_linker_flags) do
    vals = cc_linker_flags |> Map.from_struct() |> Map.values()
    Enum.filter(vals, &is_struct(&1, Flag))
  end
end
