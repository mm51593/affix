defmodule FlagsBase do
  defmacro __using__(_) do
    quote do
      def new(flags_map) do
        flags_map
        |> Map.new(fn {k, v} -> {k, %Flag{key: k, value: v}} end)
        |> then(&struct(__MODULE__, &1))
      end

      def render(flags) do
        flags = __MODULE__.get_flags(flags)
        Enum.flat_map(flags, &__MODULE__.render_flag(&1))
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
  end
end
