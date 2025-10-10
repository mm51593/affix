defmodule CcFlags do
  use FlagsBase

  defstruct [
    :flag_include,
    :flag_output,
    :flag_no_link?
  ]

  def get_switch(:flag_include), do: "-I"
  def get_switch(:flag_output), do: "-o"
  def get_switch(:flag_no_link?), do: "-c"

  def get_flags(cc_flags) do
    vals = cc_flags |> Map.from_struct() |> Map.values()
    Enum.filter(vals, &is_struct(&1, Flag))
  end
end
