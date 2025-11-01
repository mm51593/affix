defmodule Shell do
  def exec(cmd, args) do
    {output, exit_code} = System.cmd(cmd, args)
    IO.puts("cmd: #{cmd}:")
    IO.inspect(args)
    IO.puts("output:\n#{output}")
    IO.puts("exit code: #{exit_code}")
    {output, exit_code}
  end
end
