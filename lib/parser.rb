# frozen_string_literal: true

# loads the file from given path
class Parser
  SUPPORTED_FILE_FORMATS = ['.log']

  def initialize(path)
    raise "file not found: #{path}" unless File.exist?(path)
    raise "File format not allowed. Only '.log' extension files allowed" unless SUPPORTED_FILE_FORMATS.include?(File.extname(path))
  end
end
