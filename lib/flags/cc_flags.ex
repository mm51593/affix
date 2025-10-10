defmodule CcFlags do
  defstruct [
    :flag_include,
    :flag_output,
    :flag_no_link?
  ]

  def get_switch(:flag_include), do: "-I"
  def get_switch(:flag_output), do: "-o"
  def get_switch(:flag_no_link?), do: "-c"

  def new(flags_map) do
    flags_map
    |> Map.new(fn {k, v} -> {k, %Flag{key: k, value: v}} end)
    |> then(&struct(__MODULE__, &1))
  end

  def get_flags(cc_flags) do
    vals = cc_flags |> Map.from_struct() |> Map.values()
    Enum.filter(vals, &is_struct(&1, Flag))
  end

  def render_flag(%Flag{value: nil}), do: []
  def render_flag(%Flag{value: false}), do: []
  def render_flag(%Flag{value: ""}), do: []
  def render_flag(%Flag{value: true, key: key}), do: [__MODULE__.get_switch(key)]

  def render_flag(%Flag{value: value, key: key}) when is_list(value),
    do: Enum.flat_map(value, fn x -> [__MODULE__.get_switch(key), x] end)

  def render_flag(%Flag{value: value, key: key}),
    do: [__MODULE__.get_switch(key), value]
end

defimpl Flags, for: CcFlags do
  def render(cc_flags) do
    flags = CcFlags.get_flags(cc_flags)
    Enum.flat_map(flags, &CcFlags.render_flag(&1))
  end
end
