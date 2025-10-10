defmodule CcFlags do
  use FlagsBase

  defstruct [
    :flag_include,
    :flag_output,
    flag_no_link?: true
  ]

  def get_switch(:flag_include), do: "-I"
  def get_switch(:flag_output), do: "-o"
  def get_switch(:flag_no_link?), do: "-c"
end
