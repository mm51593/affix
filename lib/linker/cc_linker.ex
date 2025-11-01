defmodule CcLinker do
  @behaviour Linker

  @link_spec [
    cc: {:exe},
    src: {:positional},
    libs: {:option, "-l"},
    target: {:option, "-o"}
  ]

  def link(props) do
    args = Args.build_args(@link_spec, props)
    {_, exit_code} = Shell.exec(args.exe, args.option ++ args.positional)
    exit_code
  end
end
