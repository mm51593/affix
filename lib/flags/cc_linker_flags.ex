defmodule CcLinkerFlags do
  use FlagsBase

  defstruct [
    :flag_output,
    :flag_libs
  ]

  def get_switch(:flag_output), do: "-o"
  def get_switch(:flag_libs), do: "-l"
end
