defmodule ArgsBuilder do
  def build_args(args_spec, props) do
    args_spec
    |> Enum.map(fn {key, spec} -> {spec, props[key]} end)
    |> Enum.map(&prop_to_arg(&1))
    |> Enum.reject(&is_nil(&1))
    |> Enum.reduce(%{}, fn {type, arg}, acc -> Map.update(acc, type, arg, &(&1 ++ arg)) end)
  end

  defp prop_to_arg({_, nil}), do: nil
  defp prop_to_arg({{:exe}, v}), do: {:exe, List.flatten([v])}
  defp prop_to_arg({{:positional}, v}), do: {:positional, List.flatten([v])}
  defp prop_to_arg({{:toggle, flag}, true}), do: {:toggle, [flag]}

  defp prop_to_arg({{:option, flag}, v}) do
    args =
      List.flatten([v])
      |> Enum.map(fn opt -> [flag, opt] end)
      |> List.flatten()

    {:option, args}
  end

  defp prop_to_arg(_), do: nil
end
