defprotocol CompilerFlags do
  def include_dirs(flags)
  def output_name(flags)
  def no_link(flags)
end
