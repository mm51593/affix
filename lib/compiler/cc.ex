defmodule Cc do
  @behaviour Compiler

  @compile_spec [
    cc: {:exe},
    src: {:positional},
    include: {:option, "-I"},
    target: {:option, "-o"}
  ]

  @preprocess_spec [
    cc: {:exe},
    src: {:positional},
    include: {:option, "-I"},
    target: {:option, "-o"}
  ]

  def compile(props) do
    args = Args.build_args(@compile_spec, props)
    {_, exit_code} = Shell.exec(args.exe, ["-c" | args.option ++ args.positional])
    exit_code
  end

  def preprocess(props) do
    args = Args.build_args(@preprocess_spec, props)
    {_, exit_code} = Shell.exec(args.exe, ["-E" | args.option ++ args.positional])
    exit_code
  end
end

