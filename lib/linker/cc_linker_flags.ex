defmodule CcLinkerFlags do
  defstruct [
    :flag_output,
    :flag_libs
  ]

  def get_switch(:flag_output), do: "-o"
  def get_switch(:flag_libs), do: "-l"

  def new(flags_map) do
    flags_map
    |> Map.new(fn {k, v} -> {k, %Flag{key: k, value: v}} end)
    |> then(&struct(__MODULE__, &1))
  end

  def get_flags(cc_linker_flags) do
    vals = cc_linker_flags |> Map.from_struct() |> Map.values()
    Enum.filter(vals, &is_struct(&1, Flag))
  end

  def render_flag(%{value: nil}), do: []
  def render_flag(%{value: false}), do: []
  def render_flag(%{value: ""}), do: []
  def render_flag(%{value: true, key: key}), do: [__MODULE__.get_switch(key)]

  def render_flag(%{value: value, key: key}) when is_list(value),
    do: Enum.flat_map(value, fn x -> [__MODULE__.get_switch(key), x] end)

  def render_flag(%{value: value, key: key}),
    do: [__MODULE__.get_switch(key), value]
end

defimpl Flags, for: CcLinkerFlags do
  def render(cc_linker_flags) do
    flags = CcLinkerFlags.get_flags(cc_linker_flags)
    Enum.flat_map(flags, &CcLinkerFlags.render_flag(&1))
  end
end
