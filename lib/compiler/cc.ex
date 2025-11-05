defmodule Cc do
  defmodule Compile do
    @behaviour Action
    
    @compile_spec [
      cc: {:exe},
      src: {:positional},
      include: {:option, "-I"},
      target: {:option, "-o"}
    ]

    def perform(props) do
      args = Args.build_args(@compile_spec, props)
      {_, exit_code} = Shell.exec(args.exe, ["-c" | args.option ++ args.positional])
      if exit_code != 0, do: throw("#{args.exe} returned error code: #{exit_code}")

      List.flatten([props[:target]])
    end
  end

  defmodule Preprocess do
    @behaviour Action

    @preprocess_spec [
      cc: {:exe},
      src: {:positional},
      include: {:option, "-I"},
      target: {:option, "-o"}
    ]

    def perform(props) do  
      args = Args.build_args(@preprocess_spec, props)
      {_, exit_code} = Shell.exec(args.exe, ["-E" | args.option ++ args.positional])
      if exit_code != 0, do: throw("#{args.exe} returned error code: #{exit_code}")

      List.flatten([props[:target]])
    end
  end
end

