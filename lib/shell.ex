defmodule Shell do
  def exec(exe, args) do
    {output, exit_code} = System.cmd(exe, args)
    IO.puts("exe: #{exe}:")
    IO.inspect(args)
    IO.puts("output:\n#{output}")
    IO.puts("exit code: #{exit_code}")
    {output, exit_code}
  end

  def exec(exe, cmd, flags, positional) do
    exec(exe, cmd ++ flags ++ positional)
  end
end
