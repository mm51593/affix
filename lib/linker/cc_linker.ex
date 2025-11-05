defmodule CcLinker do
  defmodule Link do
    @behaviour Action
    
    @link_spec [
      cc: {:exe},
      src: {:positional},
      libs: {:option, "-l"},
      target: {:option, "-o"}
    ]
    
    def perform(props) do
      args = Args.build_args(@link_spec, props)
      {_, exit_code} = Shell.exec(args.exe, args.option ++ args.positional)
      if exit_code != 0, do: throw("#{args.exe} returned error code: #{exit_code}")

      List.flatten([props[:target]])
    end
  end
end
