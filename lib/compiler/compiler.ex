defprotocol Compiler do
  def compile(compiler, src_files, flags)
  def preprocess(compiler, src_files, flags)
end
