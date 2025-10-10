defmodule Flag do
  defstruct [:switch, :value]

  def render(flag) when is_list(flag.value) do
    Enum.flat_map(
      flag.value,
      fn x -> [flag.switch, flag.value] end
    )
  end

  def render(flag) when is_bool(flag.value) do
    if flag.value do [flag.switch], else []
  end

  def render(flag) when is_nil(flag.value) do
    []
  end

  def render(flag) do
    [flag.switch, flag.value]
  end
end
