defmodule FlagsBase do
  defmacro __using__(_) do
    quote do
      def render(flags) do
        flags = Map.from_struct(flags)
        Enum.flat_map(flags, &__MODULE__.render_flag(&1))
      end

      def render_flag({_, nil}), do: []
      def render_flag({_, false}), do: []
      def render_flag({_, ""}), do: []
      def render_flag({k, true}), do: [__MODULE__.get_switch(k)]

      def render_flag({k, v}) when is_list(v),
        do: Enum.flat_map(v, fn x -> [__MODULE__.get_switch(k), x] end)

      def render_flag({k, v}),
        do: [__MODULE__.get_switch(k), v]
    end
  end
end
