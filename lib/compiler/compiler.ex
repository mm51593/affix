defprotocol Compiler do
  def compile(compiler, files, flags)
  def preprocess(compiler, files, flags)
end
